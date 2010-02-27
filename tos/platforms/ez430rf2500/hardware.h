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
#define __MSP430_REV__ 'F'
#endif

#include "msp430hardware.h"

// LED
TOSH_ASSIGN_PIN(RED_LED, 1, 0);
TOSH_ASSIGN_PIN(GREEN_LED, 1, 1);
// SW
TOSH_ASSIGN_PIN(PUSH_SW, 1, 2);

// GIO pins
TOSH_ASSIGN_PIN(GIO20, 2, 0);
TOSH_ASSIGN_PIN(GIO21, 2, 1);
TOSH_ASSIGN_PIN(GIO22, 2, 2);
TOSH_ASSIGN_PIN(GIO23, 2, 3);
TOSH_ASSIGN_PIN(GIO24, 2, 4);
// UCB0
TOSH_ASSIGN_PIN(GIO30, 3, 0);
TOSH_ASSIGN_PIN(GIO31, 3, 1);
TOSH_ASSIGN_PIN(GIO32, 3, 2);
TOSH_ASSIGN_PIN(GIO33, 3, 3);
//
TOSH_ASSIGN_PIN(GIO43, 4, 3);
TOSH_ASSIGN_PIN(GIO44, 4, 4);
TOSH_ASSIGN_PIN(GIO45, 4, 5);
TOSH_ASSIGN_PIN(GIO46, 4, 6);
// Xtal
TOSH_ASSIGN_PIN(GIO26, 2, 6);
TOSH_ASSIGN_PIN(GIO27, 2, 7);

#endif // _H_hardware_h

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
