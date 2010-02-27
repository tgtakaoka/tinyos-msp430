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

#ifndef _H_hardware_h
#define _H_hardware_h

#if !defined(__MSP430__REV__)
#define __MSP430_REV__ 'G'
#endif

#include "msp430hardware.h"

// LED
TOSH_ASSIGN_PIN(RED_LED, 1, 0);

// GIO pins
TOSH_ASSIGN_PIN(GIO1, 1, 1); // BSL out
TOSH_ASSIGN_PIN(GIO2, 1, 2);
TOSH_ASSIGN_PIN(GIO3, 1, 3);
TOSH_ASSIGN_PIN(GIO4, 1, 4);
TOSH_ASSIGN_PIN(GIO5, 1, 5);
TOSH_ASSIGN_PIN(GIO6, 1, 6);
TOSH_ASSIGN_PIN(GIO7, 1, 7);

// P2.6=XIN, P2.7=XOUT
TOSH_ASSIGN_PIN(GIO8, 2, 0);
TOSH_ASSIGN_PIN(GIO9, 2, 1);
TOSH_ASSIGN_PIN(GIO10, 2, 2); // BSL in
TOSH_ASSIGN_PIN(GIO11, 2, 3);
TOSH_ASSIGN_PIN(GIO12, 2, 4);
TOSH_ASSIGN_PIN(GIO13, 2, 5);
//TOSH_ASSIGN_PIN(GIO14, 2, 6);
//TOSH_ASSIGN_PIN(GIO15, 2, 7);

#endif // _H_hardware_h

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
