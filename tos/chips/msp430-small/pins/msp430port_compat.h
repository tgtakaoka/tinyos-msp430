/* -*- mode: c; mode: flyspell-prog; -*- */
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

#ifndef _H_msp430port_compat_h
#define _H_msp430port_compat_h

#if defined(__MSP430F2001__) || defined(__MSP430F2002__) || defined(__MSP430F2003__) || \
    defined(__MSP430F2011__) || defined(__MSP430F2012__) || defined(__MSP430F2013__) || \
    defined(__MSP430G2001__) || \
    defined(__MSP430G2101__) || defined(__MSP430G2111__) || \
    defined(__MSP430G2121__) || defined(__MSP430G2131__) || \
    defined(__MSP430G2201__) || defined(__MSP430G2211__) || \
    defined(__MSP430G2221__) || defined(__MSP430G2231__)
/* These devices have only P2.6 and P2.7 at Port2 */
#define __msp430_have_port2_67
#endif
    
#if defined(__MSP430F1101__) || defined(__MSP430F1111__) || defined(__MSP430F1121__) || \
    defined(__MSP430F1122__) || defined(__MSP430F1132__)
/* These devices have only P2.0 through P2.5 at Port2 */
#define __msp430_have_port2_05
#endif
    
#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
