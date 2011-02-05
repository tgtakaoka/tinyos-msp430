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

#ifndef _H_slaz018_h
#define _H_slaz018_h

/* See SLAZ018C MSP430F15x/16x/161x Device Erratasheet, Revised February 2010 */

#if defined(__MSP430_155__) || defined(__MSP430_156__) || defined(__MSP430_157__) || \
    defined(__MSP430_167__) || defined(__MSP430_168__) || defined(__MSP430_169__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'B'"
#define __MSP430_REV__ 'B'
#endif
#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' \
    || __MSP430_REV__ == 'E'
#define ERRATA_ADC18
#define ERRATA_ADC25
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_I2C7
#define ERRATA_I2C8
#define ERRATA_I2C9
#define ERRATA_I2C10
#define ERRATA_I2C11
#define ERRATA_I2C12
#define ERRATA_I2C13
#define ERRATA_I2C14
#define ERRATA_I2C15
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TAB22
#define ERRATA_TB2
#define ERRATA_TB16
#define ERRATA_US15
#define ERRATA_WDG2
#endif
#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C'
#define ERRATA_SVS2
#define ERRATA_US14
#endif
#if __MSP430_REV__ == 'B'
#define ERRATA_XOSC4
#endif

#elif defined(__MSP430_1610_) || defined(__MSP430_1611__) || defined(__MSP430_1612__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif
#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B'
#define ERRATA_ADC18
#define ERRATA_ADC25
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_DMA9
#define ERRATA_I2C7
#define ERRATA_I2C8
#define ERRATA_I2C9
#define ERRATA_I2C10
#define ERRATA_I2C11
#define ERRATA_I2C12
#define ERRATA_I2C13
#define ERRATA_I2C14
#define ERRATA_I2C15
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TAB22
#define ERRATA_TB2
#define ERRATA_TB16
#define ERRATA_US15
#define ERRATA_WDG2
#endif
#if __MSP430_REV__ == 'A'
#define ERRATA_SVS2
#define ERRATA_US14
#endif

#else
#error "This errata/slaz018.h is for MSP430F15x/16x/161x"
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
