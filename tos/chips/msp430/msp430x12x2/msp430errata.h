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

/* See SLAZ009 MSP430F11x2/12x2 Device Erratasheet, Revised April 2006 */

#if defined(__MSP430_1222__) || defined(__MSP430_1232__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif

#if __MSP430_REV__ == 'D'
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_PORT3
#define ERRATA_RES4
#define ERRATA_TA12
#define ERRATA_TA13
#define ERRATA_TA16
#define ERRATA_US13
#define ERRATA_US15
#define ERRATA_WDG2
#endif

#else
#error "This msp430errata.h is for MSP430F12x2"
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
