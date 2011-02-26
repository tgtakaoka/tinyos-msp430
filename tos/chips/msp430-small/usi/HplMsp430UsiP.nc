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

module HplMsp430UsiP @safe() {
    provides {
        interface HplMsp430Usi as Usi;
        interface HplMsp430UsiInterrupts as Interrupts;
    }

    uses {
        interface HplMsp430GeneralIO as SIMO;
        interface HplMsp430GeneralIO as SOMI;
        interface HplMsp430GeneralIO as UCLK;
        interface HplMsp430GeneralIO as SCL;
        interface HplMsp430GeneralIO as SDA;  

        interface HplMsp430UsiInterrupts as UsiInterrupts;
    }
}
implementation {
    MSP430REG_NORACE(USICTL0);
    MSP430REG_NORACE(USICTL1);
    MSP430REG_NORACE(USICKCTL);
    MSP430REG_NORACE(USICNT);
    MSP430REG_NORACE(USISRL);

    async event void UsiInterrupts.transmitDone(uint8_t temp) {
        signal Interrupts.transmitDone(temp);
    }

    async event void UsiInterrupts.startDetected() {
        signal Interrupts.startDetected();
    }

    /* Control registers */
    async command void Usi.setUsictl0(msp430_usictl0_t control) {
        USICTL0 = usictl02int(control);
    }

    async command msp430_usictl0_t Usi.getUsictl0() {
        return int2usictl0(USICTL0);
    }

    async command void Usi.setUsictl1(msp430_usictl1_t control) {
        USICTL1 = usictl12int(control);
    }

    async command msp430_usictl1_t Usi.getUsictl1() {
        return int2usictl1(USICTL1);
    }

    async command void Usi.setUsickctl(msp430_usickctl_t control) {
        USICKCTL = usickctl2int(control);
    }

    async command msp430_usickctl_t Usi.getUsickctl() {
        return int2usickctl(USICKCTL);
    }

    async command void Usi.setUsicnt(msp430_usicnt_t control) {
        USICNT = usicnt2int(control);
    }

    async command msp430_usicnt_t Usi.getUsicnt() {
        return int2usicnt(USICNT);
    }


    /* Operations */
    async command void Usi.resetUsi(bool reset) {
        if (reset)
            SET_FLAG(USICTL0, USISWRST);
        else
            CLR_FLAG(USICTL0, USISWRST);
    }

    bool isSpi() {
        msp430_usictl1_t tmp = int2usictl1(USICTL1);
        return tmp.usii2c == 0;
    }

    bool isI2C() {
        msp430_usictl1_t tmp = int2usictl1(USICTL1);
        return tmp.usii2c == 1;
    }

    async command bool Usi.isSpi() {
        return isSpi();
    }

    async command msp430_usimode_t Usi.getMode() {
        return isSpi() ? USI_SPI : USI_I2C;
    }

    async command void Usi.enableSpi() {
        atomic {
            call SIMO.selectModuleFunc(); 
            call SOMI.selectModuleFunc();
            call UCLK.selectModuleFunc();
        }
    }

    async command void Usi.disableSpi() {
        atomic {
            call SIMO.selectIOFunc();
            call SOMI.selectIOFunc();
            call UCLK.selectIOFunc();
        }
    }

    void configSpi(const msp430_spi_union_config_t* config) {
        USICTL0 = (config->spiRegisters.usictl0 | USISWRST | USIPE7 | USIPE6 | USIPE5 | USIOE);
        USICTL1 = (config->spiRegisters.usictl1 & ~USII2C);
        USICKCTL = config->spiRegisters.usickctl;
#if defined(ERRATA_USI5)
        USICNT = 1; // USI16B=0 (8-bit); USIIFGCC=0 (USIIFG auto clear); USICNT=1
#else
        USICNT = 0; // USI16B=0 (8-bit); USIIFGCC=0 (USIIFG auto clear); USICNT=0
#endif
    }

    async command void Usi.setModeSpi(const msp430_spi_union_config_t *config) {
        atomic {
            call Usi.disableIntr();
            call Usi.clrIntr();
            // call Usi.resetUsi(TRUE);
            call Usi.enableSpi();
            configSpi(config);
            call Usi.resetUsi(FALSE);
#if defined(ERRATA_USI5)
            while ((USICTL1 & USIIFG) == 0)
                ;
#endif
        }    
    }

    async command bool Usi.isIntrPending(){
        if (USICTL1 & USIIFG)
            return TRUE;
        return FALSE;
    }

    async command void Usi.clrIntr(){
        USICTL1 &= ~USIIFG;
    }

    async command void Usi.disableIntr() {
        USICTL1 &= ~USIIE;
    }

    async command void Usi.enableIntr() {
        atomic {
            USICTL1 &= ~USIIFG;
            USICTL1 |= USIIE;
        }
    }

    async command void Usi.tx(uint8_t data) {
        USISRL = data;
        USICNT = (USICNT & ~(USICNT4 | USICNT3 | USICNT2 | USICNT1 | USICNT0)) + 8;
    }

    async command uint8_t Usi.rx() {
        return USISRL;
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
