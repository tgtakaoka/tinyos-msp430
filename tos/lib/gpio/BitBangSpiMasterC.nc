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

/** An software SPI master implementation using GPIO.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module BitBangSpiMasterC(const int mode, const int bit_endian) {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
    }
    uses {
        interface GeneralIO as SIMO;
        interface GeneralIO as SOMI;
        interface GeneralIO as CLK;
    }
}
implementation {
    void inactivateClk() {
        if (mode == SPI_MASTER_MODE0 || mode == SPI_MASTER_MODE1) {
            call CLK.clr();
        } else {
            call CLK.set();
        }
    }

    uint8_t writeSlave(uint8_t tx) {
        if (bit_endian == SPI_MASTER_MSB) {
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

    uint8_t readSlave() {
        if (bit_endian == SPI_MASTER_MSB) {
            return call SOMI.get() ? 0x01 : 0x00;
        } else {
            return call SOMI.get() ? 0x80 : 0x00;
        }
    }

    command error_t SpiControl.start() {
        inactivateClk();
        call CLK.makeOutput();
        call SIMO.makeOutput();
        call SOMI.makeInput();
        return SUCCESS;
    }

    command error_t SpiControl.stop() {
        return SUCCESS;
    }

    async command uint8_t SpiByte.write(uint8_t tx) {
        int bit = 8;
        do {
            if (mode == SPI_MASTER_MODE0 || mode == SPI_MASTER_MODE2) {
                tx = writeSlave(tx);
                call CLK.toggle();
                tx |= readSlave();
                call CLK.toggle();
            } else {
                call CLK.toggle();
                tx = writeSlave(tx);
                call CLK.toggle();
                tx |= readSlave();
            }
        } while (--bit != 0);
        return tx;
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
