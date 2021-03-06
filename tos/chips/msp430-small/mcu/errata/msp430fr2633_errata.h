/* Copyright (c) 2017, Tadashi G. Takaoka
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

#ifndef _H_slaz660_h
#define _H_slaz660_h

/* See SLAZ660Q MSP430FR2633 Device Erratasheet, Revised March 2019 */

#if defined(__MSP430FR2633__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C'
#define ERRATA_ADC50
#define ERRATA_ADC63
#define ERRATA_CPU21
#define ERRATA_CPU22
#define ERRATA_CPU40
#define ERRATA_CPU46
#define ERRATA_CS13
#define ERRATA_EEM23
#define ERRATA_GC4
#define ERRATA_GC5
#define ERRATA_PMM32
#define ERRATA_PORT28
#define ERRATA_RTC15
#define ERRATA_USCI42
#define ERRATA_USCI45
#define ERRATA_USCI47
#define ERRATA_USCI50
#endif

#if __MSP430_REV__ == 'A'
#define ERRATA_BSL18
#endif

#else
#error "This errata/slaz660.h is for MSP430FR2633"
#endif

#endif
