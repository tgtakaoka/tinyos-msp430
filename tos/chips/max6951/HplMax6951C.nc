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

#include "Max6951.h"

/** An HPL module of MAX6951 8-Digit LED Display Drivers
 *
 * Provides the ability to turn off and set integer value as zero
 * suppressed decimal, zero filled decimal, hexadecimal number.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */

generic module HplMax6951C(char resourceName[]) {
    provides interface HplMax6951 as Hpl;
    uses {
        interface StdControl as SpiControl;
        interface SpiByte;
        interface GeneralIO as CS;
        interface Boot;
    }
}
implementation {
    enum {
        ADDRESS_DECODE_MODE    = 0x0100,
        ADDRESS_INTENSITY      = 0x0200,
        ADDRESS_SCAN_LIMIT     = 0x0300,
        ADDRESS_CONFIG         = 0x0400,
        ADDRESS_DISPLAY_TEST   = 0x0700,
    };

    void event Boot.booted() {
        atomic {
            call CS.set();
            call CS.makeOutput();
            call SpiControl.start();
            call Hpl.setConfig(MAX6951_CONFIG_NORMAL | MAX6951_CONFIG_BLINK_1_0S |
                               MAX6951_CONFIG_BLINK_OFF | MAX6951_CONFIG_BLINK_ASYNC |
                               MAX6951_CONFIG_CLEAR_ASYNC);
            call Hpl.displayTest(FALSE);
            call Hpl.setScanLimit(uniqueCount(resourceName));
            call Hpl.setDecodeMode(0x00); /* segment mode */
            call Hpl.setIntensity(1);
        }
    }

    void write(uint16_t commands) {
        atomic {
            call CS.clr();
            call SpiByte.write(commands >> 8);
            call SpiByte.write(commands);
            call CS.set();
        }
    }

    command void Hpl.setDigit(uint16_t plane, uint8_t digit, uint8_t segments) {
        write((digit << 8) | plane | segments);
    }

    command void Hpl.setDecodeMode(uint8_t modes) {
        write(ADDRESS_DECODE_MODE | modes);
    }

    command void Hpl.setIntensity(uint8_t intensity) {
        write(ADDRESS_INTENSITY | intensity);
    }

    command void Hpl.setScanLimit(uint8_t digits) {
        write(ADDRESS_SCAN_LIMIT | (digits - 1));
    }

    command void Hpl.setConfig(uint8_t config) {
        write(ADDRESS_CONFIG | config);
    }

    command void Hpl.displayTest(bool enableTest) {
        write(ADDRESS_DISPLAY_TEST | enableTest);
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
