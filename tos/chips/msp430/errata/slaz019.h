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

/* See SLAZ019A MSP430F11x1(A) Device Erratasheet, Revised September 2010 */

#if defined(__MSP430_1101__) || defined(__MSP430_1111__) || defined(__MSP430_1121__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'H'"
#define __MSP430_REV__ 'H'
#endif
#if __MSP430_REV__ == 'H' || __MSP430_REV__ == 'I' || __MSP430_REV__ == 'J'
#define ERRATA_BCL5
#define ERRATA_BSL5
#define ERRATA_CPU4
#define ERRATA_PORT3
#define ERRATA_RES4
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_WDG2
#endif

#else
#error "This errata/slaz019.h is for MSP430F11x1(A)"
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
