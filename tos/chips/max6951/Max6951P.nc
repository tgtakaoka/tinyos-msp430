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

generic module Max6951P(char resourceName[]) {
    provides interface Led7Seg[int digit];
    uses {
        interface StdControl as SpiControl;
        interface SpiPacket;
        interface GeneralIO as CS;
        interface Boot;
    }
}
implementation {
    static const uint8_t hexadecimal_segments[] = {
        0x7e, 0x30, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x72,
        0x7f, 0x7b, 0x77, 0x1f, 0x4e, 0x3d, 0x4f, 0x47
    };

    uint8_t buf[2];

    async event void SpiPacket.sendDone(uint8_t *tx_buf, uint8_t* rx_buf, uint16_t len,
                                        error_t error) {
        call CS.set();
    }

    void write(unsigned data) {
        buf[0] = data >> 8;
        buf[1] = data;
        call CS.clr();
        call SpiPacket.send(buf, NULL, sizeof(buf));
    }

    void setSegments(int digit, unsigned segments) {
        write((++digit << 8) | segments);
    }

    void normal(unsigned digits) {
        write(0xb00 | (digits - 1));
        write(0xc00 | 1);
    }

    void intensity(unsigned intense) {
        write(0xa00 | intense);
    }

    void mode(unsigned bits) {
        write(0x900 | bits);
    }

    void event Boot.booted() {
        call CS.set();
        call CS.makeOutput();
        call SpiControl.start();
        normal(uniqueCount(resourceName));
        mode(0x00);         /* segment mode */
        intensity(15);
    }

    command void Led7Seg.off[int digit]() {
        setSegments(digit, 0x00);
    }

    command void Led7Seg.hexadecimal[int digit](unsigned nibble) {
        setSegments(digit, hexadecimal_segments[nibble]);
    }

    command void Led7Seg.segments[int digit](unsigned segments) {
        setSegments(digit, segments);
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
