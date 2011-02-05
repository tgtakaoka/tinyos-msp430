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

/* See SLAZ041C MSP430F21x2 Device Erratasheet, Revised January 2010 */

#if defined(__MSP430_2112__) || defined(__MSP430_2122__) || defined(__MSP430_2132__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif
#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B'
#define ERRATA_BCL12
#define ERRATA_CPU19
#define ERRATA_FLASH19
#define ERRATA_FLASH24
#define ERRATA_FLASH27
#define ERRATA_PORT12
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_USCI20
#define ERRATA_USCI21
#define ERRATA_USCI22
#define ERRATA_USCI23
#define ERRATA_USCI24
#define ERRATA_USCI25
#define ERRATA_USCI26
#define ERRATA_USCI28
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif
#if __MSP430_REV__ == 'A'
#define ERRATA_BCL13
#endif

#else
#error "This errata/slaz041.h is for MSP430F21x2"
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
