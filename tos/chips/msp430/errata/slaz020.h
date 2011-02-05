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

/* See SLAZ020H MSP430F21x1 Device Erratasheet, Revised December 2008 */

#if defined(__MSP430_2101__) || defined(__MSP430_2111__) || defined(__MSP430_2121__) || \
    defined(__MSP430_2131__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'C'"
#define __MSP430_REV__ 'C'
#endif
/* Note: Revision F is not defined */
#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || \
    __MSP430_REV__ == 'G' || __MSP430_REV__ == 'H' || __MSP430_REV__ == 'I'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_CPU11
#define ERRATA_CPU12
#define ERRATA_CPU13
#define ERRATA_CPU19
#define ERRATA_FLASH16
#define ERRATA_FLASH17
#define ERRATA_FLASH18
#define ERRATA_FLASH19
#define ERRATA_FLASH24
#define ERRATA_FLASH27
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_XOSC5
#endif
#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || \
    __MSP430_REV__ == 'G' || __MSP430_REV__ == 'H'
#define ERRATA_BCL13
#endif
#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || \
    __MSP430_REV__ == 'G'
#define ERRATA_BCL9
#define ERRATA_BCL10
#define ERRATA_BCL11
#define ERRATA_FLASH22
#define ERRATA_PORT10
#endif
#if __MSP430_REV__ == 'E' || __MSP430_REV__ == 'G'
#define ERRATA_CPU14
#endif
#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_JTAG15
#endif
#if __MSP430_REV__ == 'C' || __MSP430_REV__ == 'D'
#define ERRATA_BCL6
#define ERRATA_BCL8
#define ERRATA_CPU6
#define ERRATA_PORT8
#endif
#if __MSP430_REV__ == 'C'
#define ERRATA_BSL5
#define ERRATA_CPU5
#endif

#else
#error "This errata/slaz020.h is for MSP430F21x1"
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
