/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G Takaoka
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

#ifndef _H_msp430port_compat_h
#define _H_msp430port_compat_h

#if defined(__msp430x20x1) || defined(__msp430x20x2) || defined(__msp430x20x3) || \
    defined(__MSP430G2001) || defined(__MSP430G2101) || \
    defined(__MSP430G2111) || defined(__MSP430G2211) || \
    defined(__MSP430G2121) || defined(__MSP430G2131) || \
    defined(__MSP430G2221) || defined(__MSP430G2231)
/* These devices have only P2.6 and P2.7 at Port2 */
#define __msp430_have_restricted_port2
#endif
    
#if defined(__MSP430_HAS_PORT0__)
#define __msp430_have_port0
#endif
#if defined(__MSP430_HAS_PORT1__) || defined(__MSP430_HAS_PORT1_R__)
#define __msp430_have_port1
#endif
#if defined(__MSP430_HAS_PORT2__) || defined(__MSP430_HAS_PORT2_R__)
#define __msp430_have_port2
#endif
#if defined(__MSP430_HAS_PORT3__) || defined(__MSP430_HAS_PORT3_R__)
#define __msp430_have_port3
#endif
#if defined(__MSP430_HAS_PORT4__) || defined(__MSP430_HAS_PORT4_R__)
#define __msp430_have_port4
#endif
#if defined(__MSP430_HAS_PORT5__) || defined(__MSP430_HAS_PORT5_R__)
#define __msp430_have_port5
#endif
#if defined(__MSP430_HAS_PORT6__) || defined(__MSP430_HAS_PORT6_R__)
#define __msp430_have_port6
#endif
#if defined(__MSP430_HAS_PORT7__) || defined(__MSP430_HAS_PORT7_R__)
#define __msp430_have_port7
#endif
#if defined(__MSP430_HAS_PORT8__) || defined(__MSP430_HAS_PORT8_R__)
#define __msp430_have_port8
#endif
#if defined(__MSP430_HAS_PORT9__) || defined(__MSP430_HAS_PORT9_R__)
#define __msp430_have_port9
#endif
#if defined(__MSP430_HAS_PORT10__) || defined(__MSP430_HAS_PORT10_R__)
#define __msp430_have_port10
#endif
#if defined(__MSP430_HAS_PORT11__) || defined(__MSP430_HAS_PORT11_R__)
#define __msp430_have_port11
#endif
#if defined(__MSP430_HAS_PORTA__) || defined(__MSP430_HAS_PORTA_R__)
#define __msp430_have_porta
#endif
#if defined(__MSP430_HAS_PORTB__) || defined(__MSP430_HAS_PORTB_R__)
#define __msp430_have_portb
#endif
#if defined(__MSP430_HAS_PORTC_R__)
#define __msp430_have_portc
#endif
#if defined(__MSP430_HAS_PORTD_R__)
#define __msp430_have_portd
#endif
#if defined(__MSP430_HAS_PORTE_R__)
#define __msp430_have_porte
#endif
#if defined(__MSP430_HAS_PORTF_R__)
#define __msp430_have_portf
#endif
#if defined(__MSP430_HAS_PORTJ_R__)
#define __msp430_have_portj
#endif

#define TYPE_PORT_REN uint8_t

#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
