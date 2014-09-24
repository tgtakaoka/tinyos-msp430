/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2014, Tadashi G. Takaoka
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

#ifndef _H_slaz314_h
#define _H_slaz314_h

/* See SLAZ314L MSP430F5529 Device Erratasheet, Revised August 2014 */

#if defined(__MSP430F5529__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'C'"
#define __MSP430_REV__ 'C'
#endif

#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D'
#define ERRATA_FLASH35
#endif

#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_ADC27
#define ERRATA_FLASH_37
#define ERRATA_PMM10
#define ERRATA_PMM17
#define ERRATA_SYS10
#define ERRATA_SYS12
#define ERRATA_UCS10
#define ERRATA_USB4
#define ERRATA_USB6
#define ERRATA_USB8
#endif

#if __MSP430_REV__ == 'E'
#define ERRATA_ADC25
#endif

#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' \
    __MSP430_REV__ == 'F' || __MSP430_REV__ == 'G'
#define ERRATA_USC6
#define ERRATA_USB9
#endif

#if __MSP430_REV__ == 'F' || __MSP430_REV__ == 'G' || __MSP430_REV__ == 'H'
#define ERRATA_BSL6
#endif

#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' \
    __MSP430_REV__ == 'F' || __MSP430_REV__ == 'G' || __MSP430_REV__ == 'H' \
    __MSP430_REV__ == 'I'
#define ERRATA_ADC25
#define ERRATA_ADC42
#define ERRATA_BSL7
#define ERRATA_CPU26
#define ERRATA_CPU27
#define ERRATA_CPU28
#define ERRATA_CPU29
#define ERRATA_CPU30
#define ERRATA_CPU31
#define ERRATA_CPU32
#define ERRATA_CPU33
#define ERRATA_CPU34
#define ERRATA_CPU35
#define ERRATA_CPU37
#define ERRATA_CPU39
#define ERRATA_CPU40
#define ERRATA_CPU43
#define ERRATA_DMA4
#define ERRATA_DMA8
#define ERRATA_DMA10
#define ERRATA_EEM9
#define ERRATA_EEM11
#define ERRATA_EEM13
#define ERRATA_EEM14
#define ERRATA_EEM15
#define ERRATA_EEM16
#define ERRATA_EEM17
#define ERRATA_EEM19
#define ERRATA_EEM21
#define ERRATA_EEM23
#define ERRATA_FLASH33
#define ERRATA_FLASH34
#define ERRATA_JTAG20
#define ERRATA_MPY1
#define ERRATA_PMAP1
#define ERRATA_PMM9
#define ERRATA_PMM11
#define ERRATA_PMM12
#define ERRATA_PMM14
#define ERRATA_PMM15
#define ERRATA_PMM18
#define ERRATA_PMM20
#define ERRATA_PORT15
#define ERRATA_PORT16
#define ERRATA_PORT19
#define ERRATA_RTC3
#define ERRATA_RTC6
#define ERRATA_SYS16
#define ERRATA_SYS18
#define ERRATA_UCS7
#define ERRATA_UCS9
#define ERRATA_UCS11
#define ERRATA_USB10
#define ERRATA_USB12
#define ERRATA_USCI26
#define ERRATA_USCI31
#define ERRATA_USCI34
#define ERRATA_USCI35
#define ERRATA_USCI39
#define ERRATA_WDG4
#endif

#if __MSP430_REV__ == 'I'
#define ERRATA_USB11
#endif

#else
#error "This errata/slaz314.h is for MSP430F5529"
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
