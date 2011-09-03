/* -*- mode: c; mode: flyspell-prog; -*- */
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

#ifndef _H_slaz059_h
#define _H_slaz059_h

/* See SLAZ059I MSP430F550x, MSP430F5510 Device Erratasheet, Revised June 2011 */

#if defined(__MSP430F5500__) || defined(__MSP430F5501__) || \
    defined(__MSP430F5502__) || defined(__MSP430F5503__) || \
    defined(__MSP430F5504__) || defined(__MSP430F5505__) || defined(__MSP430F5506__) || \
    defined(__MSP430F5507__) || defined(__MSP430F5508__) || defined(__MSP430F5509__) || \
    defined(__MSP430F5510__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'C'
#if defined(__MSP430F5504__) || defined(__MSP430F5505__) || defined(__MSP430F5506__) || \
    defined(__MSP430F5507__) || defined(__MSP430F5508__) || defined(__MSP430F5509__) || \
    defined(__MSP430F5510__)
#define ERRATA_ADC30
#define ERRATA_ADC31
#endif
#define ERRATA_CPU35
#define ERRATA_CPU39
#define ERRATA_CPU40
#define ERRATA_DMA4
#define ERRATA_EEM11
#define ERRATA_EEM13
#define ERRATA_EEM17
#define ERRATA_FLASH37
#define ERRATA_JTAG20
#define ERRATA_MPY1
#define ERRATA_PMAP1
#define ERRATA_PMM9
#define ERRATA_PMM10
#define ERRATA_PMM11
#define ERRATA_PMM12
#define ERRATA_PMM14
#define ERRATA_PMM15
#define ERRATA_PORT15
#define ERRATA_RTC4
#define ERRATA_SYS16
#define ERRATA_TAB23
#define ERRATA_UCS6
#define ERRATA_UCS7
#define ERRATA_UCS9
#define ERRATA_UCS10
#define ERRATA_USB8
#define ERRATA_USCI26
#define ERRATA_USCI30
#define ERRATA_WDG4
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B'
#if defined(__MSP430F5504__) || defined(__MSP430F5505__) || defined(__MSP430F5506__) || \
    defined(__MSP430F5507__) || defined(__MSP430F5508__) || defined(__MSP430F5509__) || \
    defined(__MSP430F5510__)
#define ERRATA_ADC26
#endif

#if __MSP430_REV__ == 'A'
#define ERRATA_SYS10
#endif

#else
#error "This errata/slaz059.h is for MSP430F550x/5510"
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
