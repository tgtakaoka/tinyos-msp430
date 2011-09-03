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

#ifndef _H_slaz026_h
#define _H_slaz026_h

/* See SLAZ026P MSP430F20xx Device Erratasheet, Revised June 2011 */

#if defined(__MSP430F2001__) || defined(__MSP430F2011__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || \
    __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F' || \
    __MSP430_REV__ == 'G'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_FLASH16
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_XOSC5
#endif
#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || \
    __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_XOSC8
#endif
#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C'
#define ERRATA_BCL9
#define ERRATA_BCL10
#define ERRATA_BCL11
#define ERRATA_BCL13
#define ERRATA_FLASH22
#define ERRATA_PORT10
#endif
#if __MSP430_REV__ == 'A'
#define ERRATA_SBW1
#define ERRATA_TA17
#endif

#elif defined(__MSP430F2002__) || defined(__MSP430F2012__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || \
    __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_FLASH16
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_USI4
#define ERRATA_USI5
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif
#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C'
#define ERRATA_BCL9
#define ERRATA_BCL10
#define ERRATA_BCL11
#define ERRATA_BCL13
#define ERRATA_FLASH22
#define ERRATA_PORT10
#endif
#if __MSP430_REV__ == 'A'
#define ERRATA_SBW1
#endif

#elif defined(__MSP430F2003__) || defined(__MSP430F2013__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'B'"
#define __MSP430_REV__ 'B'
#endif

#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || \
    __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F' || __MSP430_REV__ == 'G'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_FLASH16
#define ERRATA_SDA3
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_USI4
#define ERRATA_USI5
#define ERRATA_XOSC5
#endif
#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || \
    __MSP430_REV__ == 'E'
#define ERRATA_XOSC8
#endif
#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D'
#define ERRATA_BCL9
#define ERRATA_BCL10
#define ERRATA_BCL11
#define ERRATA_BCL13
#define ERRATA_FLASH22
#define ERRATA_PORT10
#endif
#if __MSP430_REV__ == 'B'
#define ERRATA_SDA2
#define ERRATA_TA17
#define ERRATA_USI1
#define ERRATA_USI2
#define ERRATA_USI3
#endif

#else
#error "This errata/slaz026.h is for MSP430F20xx"
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
