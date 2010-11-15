/* -*- mode: c; mode: flyspell-prog; -*- */
/*
 * Copyright (C) 2010 Tadashi G. Takaoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _H_msp430errata_h
#define _H_msp430errata_h

/* See SLAZ061A MSP430G2x01, G2x11, G2x21, G2x31 Device Erratasheet, Revised May 2010 */

#if defined(__MSP430_2001__) \
    || defined(__MSP430_2101__) || defined(__MSP430_2111__) \
    || defined(__MSP430_2121__) || defined(__MSP430_2131__) \
    || defined(__MSP430_2201__) || defined(__MSP430_2211__) \
    || defined(__MSP430_2221__) || defined(__MSP430_2231__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif

#if __MSP430_REV__ == 'D'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_FLASH16
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#if defined(__MSP430_2121__) || defined(__MSP430__2131__) \
    || defined(__MSP430__2221__) || defined(__MSP430_2231__)
#define ERRATA_USI4
#define ERRATA_USI5
#endif
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif

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
