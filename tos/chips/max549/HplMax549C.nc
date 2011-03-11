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

#include "Max549.h"

/** An HPL module of MAX549 2ch 8-bit DAC
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module HplMax549C() {
    provides interface HplMax549 as Hpl;
    uses {
        interface StdControl as SpiControl;
        interface SpiByte;
        interface GeneralIO as CS;
        interface Boot;
    }
}
implementation {
    enum {
        LOAD_INPUT_REG = 0x0000,
        LOAD_DAC_REG   = 0x0800,
    };

    void write(unsigned data) {
        atomic {
            call CS.clr();
            call SpiByte.write(data >> 8);
            call SpiByte.write(data);
            call CS.set();
        }
    }

    void event Boot.booted() {
        atomic {
            call CS.set();
            call CS.makeOutput();
            call SpiControl.start();
        }
    }

    async command void Hpl.setInputReg(uint16_t channel, uint8_t data) __attribute__((noinline)) {
        write(LOAD_INPUT_REG | channel | data);
    }

    async command void Hpl.setDacReg(uint16_t channel, uint8_t data) __attribute__((noinline)) {
        write(LOAD_DAC_REG | channel | data);
    }

    async command void Hpl.loadDacReg() __attribute__((noinline)) {
        write(LOAD_DAC_REG);
    }

    async command void Hpl.shutdown() __attribute__((noinline)) {
        write(0x1800);
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
