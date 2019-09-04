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

#ifndef _H_slaz391_h
#define _H_slaz391_h

/* See SLAZ391AE MSP430FR5738 Device Erratasheet, Revised March 2019 */

#if defined(__MSP430FR5738__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'H'"
#define __MSP430_REV__ 'H'
#endif

#if __MSP430_REV__ == 'H' || __MSP430_REV__ == 'J'
#define ERRATA_ADC38
#define ERRATA_ADC39
#define ERRATA_ADC42
#define ERRATA_ADC66
#define ERRATA_ADC67
#define ERRATA_ADC69
#define ERRATA_COMP10
#define ERRATA_COMP11
#define ERRATA_CPU21
#define ERRATA_CPU22
#define ERRATA_CPU40
#define ERRATA_CPU46
#define ERRATA_CPU47
#define ERRATA_CS12
#define ERRATA_DMA7
#define ERRATA_DMA9
#define ERRATA_DMA10
#define ERRATA_DMA14
#define ERRATA_EEM19
#define ERRATA_EEM23
#define ERRATA_EEM25
#define ERRATA_EEM30
#define ERRATA_EEM31
#define ERRATA_GC3
#define ERRATA_GC4
#define ERRATA_JTAG27
#define ERRATA_MPY1
#define ERRATA_PORT16
#define ERRATA_PORT19
#define ERRATA_PORT26
#define ERRATA_RTC14
#define ERRATA_TA23
#define ERRATA_USCI36
#define ERRATA_USCI37
#define ERRATA_USCI41
#define ERRATA_USCI42
#define ERRATA_USCI44
#define ERRATA_USCI47
#define ERRATA_USCI50
#define ERRATA_WDG6
#define ERRATA_XOSC13
#endif

#else
#error "This errata/slaz391.h is for MSP430FR5738"
#endif

#endif
