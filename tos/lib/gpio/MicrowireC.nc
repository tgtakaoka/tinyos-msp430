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

#include "Microwire.h"

/** An software Microwire master implementation using GPIO.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module MicrowireC(const int mode, const int bit_endian) {
    provides {
        interface StdControl as MicrowireControl;
        interface MicrowireByte;
    }
    uses {
        interface GeneralIO as SISO;
        interface GeneralIO as CLK;
    }
}
implementation {
    void activateClk() {
        if (mode == MICROWIRE_MODE0 || mode == MICROWIRE_MODE1) {
            call CLK.set();
        } else {
            call CLK.clr();
        }
    }

    void inactivateClk() {
        if (mode == MICROWIRE_MODE0 || mode == MICROWIRE_MODE1) {
            call CLK.clr();
        } else {
            call CLK.set();
        }
    }

    uint8_t writeSlave(uint8_t tx) {
        if (bit_endian == MICROWIRE_MSB) {
            if (tx & 0x80) {
                call SISO.set();
            } else {
                call SISO.clr();
            }
            tx <<= 1;
        } else {
            if (tx & 0x01) {
                call SISO.set();
            } else {
                call SISO.clr();
            }
            tx >>= 1;
        }
        return tx;
    }

    uint8_t readSlave(uint8_t rx) {
        if (bit_endian == MICROWIRE_MSB) {
            rx <<= 1;
            return call SISO.get() ? (rx | 0x01) : rx;
        } else {
            rx >>= 1;
            return call SISO.get() ? (rx | 0x80) : rx;
        }
    }

    command error_t MicrowireControl.start() {
        inactivateClk();
        call CLK.makeOutput();
        call SISO.makeInput();
        return SUCCESS;
    }

    command error_t MicrowireControl.stop() {
        return SUCCESS;
    }

    async command void MicrowireByte.write(uint8_t tx) {
        int bit = 8;
        atomic {
            call SISO.makeOutput();
            do {
                if (mode == MICROWIRE_MODE0 || mode == MICROWIRE_MODE2) {
                    tx = writeSlave(tx);
                    activateClk();
                    inactivateClk();
                } else {
                    activateClk();
                    tx = writeSlave(tx);
                    inactivateClk();
                }
            } while (--bit != 0);
            call SISO.makeInput();
        }
    }

    async command uint8_t MicrowireByte.read() {
        uint8_t rx;
        int bit = 8;
        atomic {
            call SISO.makeInput();
            do {
                if (mode == MICROWIRE_MODE0 || mode == MICROWIRE_MODE2) {
                    activateClk();
                    rx = readSlave(rx);
                    inactivateClk();
                } else {
                    activateClk();
                    inactivateClk();
                    rx = readSlave(rx);
                }
            } while (--bit != 0);
        }
        return rx;
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
