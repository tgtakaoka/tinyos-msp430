/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G. Takaoka
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

/** An interface to arbitrary digits of 7 segments LEDs.
 *
 * Provides the ability to turn off and set integer value as zero
 * suppressed decimal, zero filled decimal, hexadecimal number.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module Led7SegsC(char name[], int numDigits, typedef size_type @integer()) {
    provides interface Led7Segs<size_type>;
    uses interface Led7Seg[int digits];
}
implementation {
    enum {
        OFFSET = uniqueN(name, numDigits),
    };

    command int Led7Segs.offset() {
        return OFFSET;
    }

    command int Led7Segs.digits() {
        return numDigits;
    }

    command void Led7Segs.off() {
        int i;
        for (i = 0; i < numDigits; i++) {
            call Led7Seg.off[OFFSET + i]();
        }
    }

    command void Led7Segs.decimal(size_type val) {
        int i;
        bool suppress = FALSE;
        for (i = 0; i < numDigits; i++) {
            if (suppress) {
                call Led7Seg.off[OFFSET + i]();
            } else {
                call Led7Seg.hexadecimal[OFFSET + i](val % 10);
            }
            if ((val /= 10) == 0)
                suppress = TRUE;
        }
    }

    command void Led7Segs.decimal0(size_type val) {
        int i;
        for (i = 0; i < numDigits; i++) {
            call Led7Seg.hexadecimal[OFFSET + i](val % 10);
            val /= 10;
        }
    }

    command void Led7Segs.hexadecimal(size_type val) {
        int i;
        for (i = 0; i < numDigits; i++) {
            call Led7Seg.hexadecimal[OFFSET + i](val % 16);
            val /= 16;
        }
    }

    command void Led7Segs.segments(int digit, unsigned segments) {
        call Led7Seg.segments[OFFSET + digit](segments & 0xff);
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
