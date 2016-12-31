/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2013, Tadashi G. Takaoka
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

#include "msp430regtypes.h"

#define USE_ASM

generic module HplMsp430GeneralIORenP(
    unsigned int port_in_addr,
    unsigned int port_out_addr,
    unsigned int port_dir_addr,
    unsigned int port_sel_addr,
    unsigned int port_ren_addr,
    uint8_t pin) @safe()
{
    provides interface HplMsp430GeneralIO as IO;
}
implementation
{
#define PORTxIN (*TCAST(volatile TYPE_PORT_IN* ONE, port_in_addr))
#define PORTx (*TCAST(volatile TYPE_PORT_OUT* ONE, port_out_addr))
#define PORTxDIR (*TCAST(volatile TYPE_PORT_DIR* ONE, port_dir_addr))
#define PORTxSEL (*TCAST(volatile TYPE_PORT_SEL* ONE, port_sel_addr))
#define PORTxREN (*TCAST(volatile TYPE_PORT_REN* ONE, port_ren_addr))

    async command void IO.set() {
#ifdef USE_ASM
        /* atomic */ asm ("bis.b %0, %1" : : "n" (1 << pin), "m" (PORTx));
#else
        atomic PORTx |= (1 << pin);
#endif
    }

    async command void IO.clr() {
#ifdef USE_ASM
        /* atomic */ asm ("bic.b %0, %1" : : "n" (1 << pin), "m" (PORTx));
#else
        atomic PORTx &= ~(1 << pin);
#endif
    }

    async command void IO.toggle() {
#ifdef USE_ASM
        /* atomic */ asm ("xor.b %0, %1" : : "n" (1 << pin), "m" (PORTx));
#else
        atomic PORTx ^= (1 << pin);
#endif
    }

    async command uint8_t IO.getRaw() {
        return PORTxIN & (1 << pin);
    }

    async command bool IO.get() {
        return (call IO.getRaw() != 0);
    }

    async command void IO.makeInput() {
#ifdef USE_ASM
        /* atomic */ asm ("bic.b %0, %1" : : "n" (1 << pin), "m" (PORTxDIR));
#else
        atomic PORTxDIR &= ~(1 << pin);
#endif
    }

    async command bool IO.isInput() {
        return (PORTxDIR & (1 << pin)) == 0;
    }

    async command void IO.makeOutput() {
#ifdef USE_ASM
        /* atomic */ asm ("bis.b %0, %1" : : "n" (1 << pin), "m" (PORTxDIR));
#else
        atomic PORTxDIR |= (1 << pin);
#endif
    }

    async command bool IO.isOutput() {
        return (PORTxDIR & (1 << pin)) != 0;
    }

    async command void IO.selectModuleFunc() {
#ifdef USE_ASM
        /* atomic */ asm ("bis.b %0, %1" : : "n" (1 << pin), "m" (PORTxSEL));
#else
        atomic PORTxSEL |= (1 << pin);
#endif
    }

    async command bool IO.isModuleFunc() {
        return (PORTxSEL & (1 << pin)) != 0;
    }

    async command void IO.selectIOFunc() {
#ifdef USE_ASM
        /* atomic */ asm ("bic.b %0, %1" : : "n" (1 << pin), "m" (PORTxSEL));
#else
        atomic PORTxSEL &= ~(1 << pin);
#endif
    }

    async command bool IO.isIOFunc() {
        return (PORTxSEL & (1 << pin)) == 0;
    }

    async command error_t IO.setResistor(uint8_t mode) {
        atomic {
            if (PORTxDIR & (1 << pin))
                return FAIL;
            switch (mode) {
            case MSP430_PORT_RESISTOR_OFF:
                PORTxREN &= ~(1 << pin);
                return SUCCESS;
            case MSP430_PORT_RESISTOR_PULLDOWN:
                PORTxREN |= (1 << pin);
                PORTx &= ~(1 << pin);
                return SUCCESS;
            case MSP430_PORT_RESISTOR_PULLUP:
                PORTxREN |= (1 << pin);
                PORTx |= (1 << pin);
                return SUCCESS;
            default:
                return EINVAL;
            }
        }
    }

    async command uint8_t IO.getResistor() {
        atomic {
            if (PORTxDIR & (1 << pin))
                return MSP430_PORT_RESISTOR_INVALID;
            if (PORTxREN & (1 << pin)) {
                if (PORTx & (1 << pin)) {
                    return MSP430_PORT_RESISTOR_PULLUP;
                }
                return MSP430_PORT_RESISTOR_PULLDOWN;
            }
            return MSP430_PORT_RESISTOR_OFF;
        }
    }
}
