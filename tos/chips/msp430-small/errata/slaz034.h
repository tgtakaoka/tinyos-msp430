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

#ifndef _H_slaz034_h
#define _H_slaz034_h

/* See SLAZ034I MSP430F22x4, MSP430F22x2 Device Erratasheet, Revised Feburuary 2011 */

#if defined(__MSP430F2232__) || defined(__MSP430F2252__) || defined(__MSP430F2272__) || \
    defined(__MSP430F2234__) || defined(__MSP430F2254__) || defined(__MSP430F2274__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif

#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F' || \
    __MSP430_REV__ == 'G'
#define ERRATA_BCL12
#define ERRATA_CPU19
#define ERRATA_FLASH24
#define ERRATA_FLASH27
#define ERRATA_FLASH36
#define ERRATA_PORT10
#define ERRATA_SYS15
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TAB22
#define ERRATA_TB2
#define ERRATA_TB16
#define ERRATA_USCI20
#define ERRATA_USCI21
#define ERRATA_USCI22
#define ERRATA_USCI23
#define ERRATA_USCI24
#define ERRATA_USCI25
#define ERRATA_USCI26
#define ERRATA_USCI27
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif
#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F'
#define ERRATA_BCL13
#endif
#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_CPU14
#define ERRATA_FLASH22
#define ERRATA_JTAG14
#define ERRATA_USCI16
#endif
#if __MSP430_REV__ == 'D'
#define ERRATA_FLASH21
#define ERRATA_JTAG13
#endif

#else
#error "This errata/slaz034.h is for MSP430F22x4, MSP430F22x2"
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
