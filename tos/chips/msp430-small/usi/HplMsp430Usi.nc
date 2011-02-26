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

interface HplMsp430Usi {
    /* UCICTL0 */
    async command void setUsictl0(msp430_usictl0_t control);
    async command msp430_usictl0_t getUsictl0();

    /* UCICTL1 */
    async command void setUsictl1(msp430_usictl1_t control);
    async command msp430_usictl1_t getUsictl1();

    /* UCICKCTL */
    async command void setUsickctl(msp430_usickctl_t control);
    async command msp430_usickctl_t getUsickctl();

    /* UCICNT */
    async command void setUsicnt(msp430_usicnt_t control);
    async command msp430_usicnt_t getUsicnt();

    async command void resetUsi(bool reset);

    async command msp430_usimode_t getMode();

    async command void enableSpi();
    async command void disableSpi();
    async command bool isSpi();
    async command void setModeSpi(const msp430_spi_union_config_t *config);
  
    /* Interrupt control */
    async command void disableIntr();
    async command void enableIntr();
    async command bool isIntrPending();
    async command void clrIntr();

    async command void tx(uint8_t data);
    async command uint8_t rx();
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
