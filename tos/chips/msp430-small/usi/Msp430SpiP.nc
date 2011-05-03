/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2011, Tadashi G Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "msp430usi.h"

module Msp430SpiP {
    provides {
        interface Resource[uint8_t id];
        interface ResourceConfigure[uint8_t id];
        interface SpiByte;
        interface SpiPacket[uint8_t id];
    }

    uses {
        interface Resource as UsiResource[uint8_t id];
        interface Msp430SpiConfigure[uint8_t id];
        interface HplMsp430Usi as Usi;
        interface HplMsp430UsiInterrupts as UsiInterrupts;
    }
}

implementation {
    enum {
        SPI_ATOMIC_SIZE = 2,
    };

    norace uint16_t m_len;
    norace uint8_t* COUNT_NOK(m_len) m_txBuf;
    norace uint8_t* COUNT_NOK(m_len) m_rxBuf;
    norace uint16_t m_pos;
    norace uint8_t m_client;

    void signalDone();
    task void signalDone_task();

    async command error_t Resource.immediateRequest[uint8_t id]() {
        return call UsiResource.immediateRequest[id]();
    }

    async command error_t Resource.request[uint8_t id]() {
        return call UsiResource.request[id]();
    }

    async command uint8_t Resource.isOwner[uint8_t id]() {
        return call UsiResource.isOwner[id]();
    }

    async command error_t Resource.release[uint8_t id]() {
        return call UsiResource.release[id]();
    }

    async command void ResourceConfigure.configure[uint8_t id]() {
        call Usi.setModeSpi(call Msp430SpiConfigure.getConfig[id]());
    }

    async command void ResourceConfigure.unconfigure[uint8_t id]() {
        call Usi.resetUsi(TRUE);
        call Usi.disableSpi();
        call Usi.resetUsi(FALSE);
    }

    event void UsiResource.granted[uint8_t id]() {
        signal Resource.granted[id]();
    }

    async command uint8_t SpiByte.write(uint8_t tx) {
        uint8_t byte;
        // we are in spi mode which is configured to have turned off interrupts
        //call Usart.disableIntr();
        call Usi.tx(tx);
        while (!call Usi.isIntrPending())
            ;
        call Usi.clrIntr();
        byte = call Usi.rx();
        //call Usart.enableIntr();
        return byte;
    }

    default async command error_t UsiResource.isOwner[uint8_t id]() { return FAIL; }
    default async command error_t UsiResource.request[uint8_t id]() { return FAIL; }
    default async command error_t UsiResource.immediateRequest[uint8_t id]() { return FAIL; }
    default async command error_t UsiResource.release[uint8_t id]() { return FAIL; }
    default async command const msp430_spi_union_config_t* Msp430SpiConfigure.getConfig[uint8_t id]() {
        return &msp430_spi_default_config;
    }

    default event void Resource.granted[uint8_t id]() {}

    void continueOp() {
        uint8_t end;
        uint8_t tmp;

        atomic {
            call Usi.tx(m_txBuf ? m_txBuf[m_pos] : 0);

            end = m_pos + SPI_ATOMIC_SIZE;
            if (end > m_len)
                end = m_len;

            while (++m_pos < end) {
                while (!call Usi.isIntrPending())
                    ;
                tmp = call Usi.rx();
                if (m_rxBuf)
                    m_rxBuf[m_pos - 1] = tmp;
                call Usi.tx(m_txBuf ? m_txBuf[m_pos] : 0);
            }
        }
    }

    async command error_t SpiPacket.send[uint8_t id](
        uint8_t* txBuf, uint8_t* rxBuf, uint16_t len) {

        m_client = id;
        m_txBuf = txBuf;
        m_rxBuf = rxBuf;
        m_len = len;
        m_pos = 0;

        if (len) {
            call Usi.enableIntr();
            continueOp();
        } else {
            post signalDone_task();
        }

        return SUCCESS;
    }

    task void signalDone_task() {
        atomic signalDone();
    }

    async event void UsiInterrupts.transmitDone() {
        if (m_rxBuf)
            m_rxBuf[m_pos - 1] = USISRL;

        if (m_pos < m_len) {
            continueOp();
        } else {
            call Usi.disableIntr();
            signalDone();
        }
    }

    async event void UsiInterrupts.startDetected() {}

    void signalDone() {
        signal SpiPacket.sendDone[m_client](m_txBuf, m_rxBuf, m_len, SUCCESS);
    }

    default async event void SpiPacket.sendDone[uint8_t id](
        uint8_t* txBuf, uint8_t* rxBuf, uint16_t len, error_t error) {
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
