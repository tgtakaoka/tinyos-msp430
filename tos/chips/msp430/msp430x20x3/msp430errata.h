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

/* See SLAZ026K MSP430F20xx Device Erratasheet, Revised January 2009 */

#if defined(__MSP430_2003__) || defined(__MSP430_2013__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'B'"
#define __MSP430_REV__ 'B'
#endif

#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || \
    __MSP430_REV__ == 'E'
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

#if __MSP430_REV__ == 'B' || __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D'
#define ERRATA_BCL9
#define ERRATA_BCL10
#define ERRATA_BCL11
#define ERRATA_BCL13
#define ERRATA_FLASH22
#define ERRATA_PORT10
#endif

#if __MSP430_REV__ == 'B'
#define ERRATA_SD2
#define ERRATA_TA17
#define ERRATA_USI1
#define ERRATA_USI2
#define ERRATA_USI3
#endif

#else
#error "This msp430errata.h is for MSP430F20x3"
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
