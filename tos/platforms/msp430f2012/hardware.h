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
#define __MSP430_REV__ 'B'
#endif

#include "msp430hardware.h"

// LED
#define LED_RED Port10

// TimerA
#define TIMERA_ACLK    Port10
#define TIMERA_SCMLK   Port14
#define TIMERA_TA0     Port11
#define TIMERA_TA1     Port12
#define TIMERA_CCI0A   Port11
#define TIMERA_CCI1A   Port12
#define TIMERA_TA0_ALT Port15
#define TIMERA_TA1_ALT Port16
#define TIMERA_CCI1B   Port16

// USI
#define USI_SCLK Port15
#define USI_SDO  Port16
#define USI_SDI  Port17
#define USI_SCL  Port16
#define USI_SDA  Port17

#endif // _H_hardware_h

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
