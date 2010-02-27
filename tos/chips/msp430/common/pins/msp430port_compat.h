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

#ifndef _H_msp430port_compat_h
#define _H_msp430port_compat_h

#ifdef __MSP430_HAS_PORT1_R__
#define __msp430_have_port1
#endif
#ifdef __MSP430_HAS_PORT2_R__
#define __msp430_have_port2
#endif
#ifdef __MSP430_HAS_PORT3_R__
#define __msp430_have_port3
#endif
#ifdef __MSP430_HAS_PORT4_R__
#define __msp430_have_port4
#endif
#ifdef __MSP430_HAS_PORT5_R__
#define __msp430_have_port5
#endif
#ifdef __MSP430_HAS_PORT6_R__
#define __msp430_have_port6
#endif
#ifdef __MSP430_HAS_PORT7_R__
#define __msp430_have_port7
#endif
#ifdef __MSP430_HAS_PORT8_R__
#define __msp430_have_port8
#endif
#ifdef __MSP430_HAS_PORT9_R__
#define __msp430_have_port9
#endif
#ifdef __MSP430_HAS_PORT10_R__
#define __msp430_have_port10
#endif

#define TYPE_PORT_REN uint8_t

#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
