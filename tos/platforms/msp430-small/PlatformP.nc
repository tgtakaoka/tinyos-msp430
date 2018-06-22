/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2010-2011, Tadashi G. Takaoka
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

module PlatformP {
    provides {
        interface Init;
        interface Platform;
    }
    uses {
        interface Init as Msp430ClockInit;
        interface Init as LedsInit;
    }
}
implementation {
    command error_t Init.init() {
        WDTCTL = WDTPW + WDTHOLD;
        call LedsInit.init();
        call Msp430ClockInit.init();
        return SUCCESS;
    }

    async command uint32_t Platform.localTime()      { return 0; }
    async command uint32_t Platform.usecsRaw()       { return 0; }
    async command uint32_t Platform.usecsRawSize()   { return 0; }
    async command uint32_t Platform.jiffiesRaw()     { return 0; }
    async command uint32_t Platform.jiffiesRawSize() { return 0; }
    async command bool     Platform.set_unaligned_traps(bool on_off) {
        return FALSE;
    }

    default command error_t LedsInit.init() {
        return SUCCESS;
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
