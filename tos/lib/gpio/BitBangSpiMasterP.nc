/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2011, Tadashi G. Takaoka
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

#include "BitBangSpiMaster.h"

/** A software SPI master implementation using GPIO.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module BitBangSpiMasterP() {
    provides {
        interface ResourceConfigure[uint8_t id];
        interface SpiByte;
        interface SpiPacket[uint8_t id];
    }
    uses {
        // Default: ClockPolarity=Positive, ClockPhase=LeadingEdge, BitEndian=MsbFirst
        interface BitBangSpiMasterConfigure as Configure[uint8_t id];
        interface GeneralIO as SIMO;
        interface GeneralIO as SOMI;
        interface GeneralIO as CLK;
    }
}
implementation {

#if defined(BIT_BANG_SPI_MASTER_SINGLE_CONFIG)
#define GET_CONFIG(id)       BIT_BANG_SPI_MASTER_SINGLE_CONFIG
#define GET_CURRENT_CONFIG() BIT_BANG_SPI_MASTER_SINGLE_CONFIG
#else
    norace bit_bang_spi_master_config_t mCurrentConfig;
#define GET_CONFIG(id)       (mCurrentConfig = call Configure.getConfig[id]())
#define GET_CURRENT_CONFIG() mCurrentConfig
#endif

    void inactivateClk(const bit_bang_spi_master_config_t config) {
        if (config & BIT_BANG_SPI_MASTER_CLK_POLALITY_POSITIVE) {
            call CLK.clr();
        } else {
            call CLK.set();
        }
    }

    uint8_t writeSlave(uint8_t tx, const bit_bang_spi_master_config_t config) {
        if (config & BIT_BANG_SPI_MASTER_BIT_BIG_ENDIAN) {
            if (tx & 0x80) {
                call SIMO.set();
            } else {
                call SIMO.clr();
            }
            tx <<= 1;
        } else {
            if (tx & 0x01) {
                call SIMO.set();
            } else {
                call SIMO.clr();
            }
            tx >>= 1;
        }
        return tx;
    }

    uint8_t readSlave(const bit_bang_spi_master_config_t config) {
        if (config & BIT_BANG_SPI_MASTER_BIT_BIG_ENDIAN) {
            return call SOMI.get() ? 0x01 : 0x00;
        } else {
            return call SIMO.get() ? 0x80 : 0x00;
        }
    }

    async command void ResourceConfigure.configure[uint8_t id]() {
        inactivateClk(GET_CONFIG(id));
        call CLK.makeOutput();
        call SIMO.makeOutput();
        call SOMI.makeInput();
    }

    async command void ResourceConfigure.unconfigure[uint8_t id]() {
        inactivateClk(GET_CURRENT_CONFIG());
    }

    async command uint8_t SpiByte.write(uint8_t tx) {
        const bit_bang_spi_master_config_t config = GET_CURRENT_CONFIG();
        int bit = 8;
        do {
            if (config & BIT_BANG_SPI_MASTER_CLK_PHASE_LEADING_EDGE) {
                tx = writeSlave(tx, config);
                call CLK.toggle();
                tx |= readSlave(config);
                call CLK.toggle();
            } else {
                call CLK.toggle();
                tx = writeSlave(tx, config);
                call CLK.toggle();
                tx |= readSlave(config);
            }
        } while (--bit != 0);
        return tx;
    }

    async command error_t SpiPacket.send[uint8_t id](
        uint8_t* txBuf, uint8_t* rxBuf, uint16_t len) {
        while (len != 0) {
            *rxBuf++ = call SpiByte.write(*txBuf++);
            len--;
        }
        return SUCCESS;
    }

    default async event void SpiPacket.sendDone[uint8_t id](
        uint8_t* txBuf, uint8_t* rxBuf, uint16_t len, error_t error) {
    }

    default async command const bit_bang_spi_master_config_t Configure.getConfig[uint8_t id]() {
        return BIT_BANG_SPI_MASTER_DEFAULT_CONFIG;
    }
}

#undef GET_CONFIG
#undef GET_CURRENT_CONFIG

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
