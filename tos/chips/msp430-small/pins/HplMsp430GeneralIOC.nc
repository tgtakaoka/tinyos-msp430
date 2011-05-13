
/* Copyright (c) 2000-2003 The Regents of the University of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * HPL for the TI MSP430 family of microprocessors. This provides an
 * abstraction for general-purpose I/O.
 *
 * @author Joe Polastre
 * @author Peter A. Bigot <pab@peoplepowerco.com>
 */

#include "msp430port_compat.h"

configuration HplMsp430GeneralIOC
{
  // provides all the ports as raw ports
#if defined(__msp430_have_port1) || defined(__MSP430_HAS_PORT1__) || defined(__MSP430_HAS_PORT1_R__)
  provides interface HplMsp430GeneralIO as Port10;
  provides interface HplMsp430GeneralIO as Port11;
  provides interface HplMsp430GeneralIO as Port12;
  provides interface HplMsp430GeneralIO as Port13;
  provides interface HplMsp430GeneralIO as Port14;
  provides interface HplMsp430GeneralIO as Port15;
  provides interface HplMsp430GeneralIO as Port16;
  provides interface HplMsp430GeneralIO as Port17;
#endif

#if defined(__msp430_have_port2) || defined(__MSP430_HAS_PORT2__) || defined(__MSP430_HAS_PORT2_R__)
#if !defined(__msp430_have_port2_67)
  provides interface HplMsp430GeneralIO as Port20;
  provides interface HplMsp430GeneralIO as Port21;
  provides interface HplMsp430GeneralIO as Port22;
  provides interface HplMsp430GeneralIO as Port23;
  provides interface HplMsp430GeneralIO as Port24;
  provides interface HplMsp430GeneralIO as Port25;
#endif
#if !defined(__msp430_have_port2_05)
  provides interface HplMsp430GeneralIO as Port26;
  provides interface HplMsp430GeneralIO as Port27;
#endif
#endif

#if defined(__msp430_have_port3) || defined(__MSP430_HAS_PORT3__) || defined(__MSP430_HAS_PORT3_R__)
  provides interface HplMsp430GeneralIO as Port30;
  provides interface HplMsp430GeneralIO as Port31;
  provides interface HplMsp430GeneralIO as Port32;
  provides interface HplMsp430GeneralIO as Port33;
  provides interface HplMsp430GeneralIO as Port34;
  provides interface HplMsp430GeneralIO as Port35;
  provides interface HplMsp430GeneralIO as Port36;
  provides interface HplMsp430GeneralIO as Port37;
#endif

#if defined(__msp430_have_port4) || defined(__MSP430_HAS_PORT4__) || defined(__MSP430_HAS_PORT4_R__)
  provides interface HplMsp430GeneralIO as Port40;
  provides interface HplMsp430GeneralIO as Port41;
  provides interface HplMsp430GeneralIO as Port42;
  provides interface HplMsp430GeneralIO as Port43;
  provides interface HplMsp430GeneralIO as Port44;
  provides interface HplMsp430GeneralIO as Port45;
  provides interface HplMsp430GeneralIO as Port46;
  provides interface HplMsp430GeneralIO as Port47;
#endif

#if defined(__msp430_have_port5) || defined(__MSP430_HAS_PORT5__) || defined(__MSP430_HAS_PORT5_R__)
  provides interface HplMsp430GeneralIO as Port50;
  provides interface HplMsp430GeneralIO as Port51;
  provides interface HplMsp430GeneralIO as Port52;
  provides interface HplMsp430GeneralIO as Port53;
  provides interface HplMsp430GeneralIO as Port54;
  provides interface HplMsp430GeneralIO as Port55;
  provides interface HplMsp430GeneralIO as Port56;
  provides interface HplMsp430GeneralIO as Port57;
#endif

#if defined(__msp430_have_port6) || defined(__MSP430_HAS_PORT6__) || defined(__MSP430_HAS_PORT6_R__)
  provides interface HplMsp430GeneralIO as Port60;
  provides interface HplMsp430GeneralIO as Port61;
  provides interface HplMsp430GeneralIO as Port62;
  provides interface HplMsp430GeneralIO as Port63;
  provides interface HplMsp430GeneralIO as Port64;
  provides interface HplMsp430GeneralIO as Port65;
  provides interface HplMsp430GeneralIO as Port66;
  provides interface HplMsp430GeneralIO as Port67;
#endif
}
implementation
{
  components 
#if defined(__MSP430_HAS_PORT1_R__)
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 0) as P10,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 1) as P11,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 2) as P12,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 3) as P13,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 4) as P14,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 5) as P15,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 6) as P16,
    new HplMsp430GeneralIORenP(P1IN_, P1OUT_, P1DIR_, P1SEL_, P1REN_, 7) as P17,
#elif defined(__msp430_have_port1) || defined(__MSP430_HAS_PORT1__)
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 0) as P10,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 1) as P11,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 2) as P12,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 3) as P13,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 4) as P14,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 5) as P15,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 6) as P16,
    new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 7) as P17,
#endif

#if defined(__MSP430_HAS_PORT2_R__)
#if !defined(__msp430_have_port2_67)
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 0) as P20,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 1) as P21,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 2) as P22,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 3) as P23,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 4) as P24,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 5) as P25,
#endif
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 6) as P26,
    new HplMsp430GeneralIORenP(P2IN_, P2OUT_, P2DIR_, P2SEL_, P2REN_, 7) as P27,
#elif defined(__msp430_have_port2) || defined(__MSP430_HAS_PORT2__)
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 0) as P20,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 1) as P21,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 2) as P22,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 3) as P23,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 4) as P24,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 5) as P25,
#if !defined(__msp430_have_port2_05)
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 6) as P26,
    new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 7) as P27,
#endif
#endif

#if defined(__MSP430_HAS_PORT3_R__)
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 0) as P30,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 1) as P31,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 2) as P32,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 3) as P33,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 4) as P34,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 5) as P35,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 6) as P36,
    new HplMsp430GeneralIORenP(P3IN_, P3OUT_, P3DIR_, P3SEL_, P3REN_, 7) as P37,
#elif defined(__msp430_have_port3) || defined(__MSP430_HAS_PORT3__)
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 0) as P30,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 1) as P31,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 2) as P32,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 3) as P33,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 4) as P34,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 5) as P35,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 6) as P36,
    new HplMsp430GeneralIOP(P3IN_, P3OUT_, P3DIR_, P3SEL_, 7) as P37,
#endif

#if defined(__MSP430_HAS_PORT4_R__)
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 0) as P40,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 1) as P41,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 2) as P42,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 3) as P43,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 4) as P44,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 5) as P45,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 6) as P46,
    new HplMsp430GeneralIORenP(P4IN_, P4OUT_, P4DIR_, P4SEL_, P4REN_, 7) as P47,
#elif defined(__msp430_have_port4) || defined(__MSP430_HAS_PORT4__)
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 0) as P40,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 1) as P41,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 2) as P42,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 3) as P43,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 4) as P44,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 5) as P45,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 6) as P46,
    new HplMsp430GeneralIOP(P4IN_, P4OUT_, P4DIR_, P4SEL_, 7) as P47,
#endif

#if defined(__MSP430_HAS_PORT5_R__)
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 0) as P50,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 1) as P51,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 2) as P52,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 3) as P53,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 4) as P54,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 5) as P55,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 6) as P56,
    new HplMsp430GeneralIORenP(P5IN_, P5OUT_, P5DIR_, P5SEL_, P5REN_, 7) as P57,
#elif defined(__msp430_have_port5) || defined(__MSP430_HAS_PORT5__)
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 0) as P50,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 1) as P51,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 2) as P52,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 3) as P53,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 4) as P54,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 5) as P55,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 6) as P56,
    new HplMsp430GeneralIOP(P5IN_, P5OUT_, P5DIR_, P5SEL_, 7) as P57,
#endif

#if defined(__MSP430_HAS_PORT6_R__)
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 0) as P60,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 1) as P61,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 2) as P62,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 3) as P63,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 4) as P64,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 5) as P65,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 6) as P66,
    new HplMsp430GeneralIORenP(P6IN_, P6OUT_, P6DIR_, P6SEL_, P6REN_, 7) as P67,
#elif defined(__msp430_have_port6) || defined(__MSP430_HAS_PORT6__)
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 0) as P60,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 1) as P61,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 2) as P62,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 3) as P63,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 4) as P64,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 5) as P65,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 6) as P66,
    new HplMsp430GeneralIOP(P6IN_, P6OUT_, P6DIR_, P6SEL_, 7) as P67,
#endif

    PlatformC; // dummy to end unknown sequence

#if defined(__msp430_have_port1) || defined(__MSP430_HAS_PORT1__) || defined(__MSP430_HAS_PORT1_R__)
  Port10 = P10;
  Port11 = P11;
  Port12 = P12;
  Port13 = P13;
  Port14 = P14;
  Port15 = P15;
  Port16 = P16;
  Port17 = P17;
#endif

#if defined(__msp430_have_port2) || defined(__MSP430_HAS_PORT2__) || defined(__MSP430_HAS_PORT2_R__)
#if !defined(__msp430_have_port2_67)
  Port20 = P20;
  Port21 = P21;
  Port22 = P22;
  Port23 = P23;
  Port24 = P24;
  Port25 = P25;
#endif
#if !defined(__msp430_have_port2_05)
  Port26 = P26;
  Port27 = P27;
#endif
#endif

#if defined(__msp430_have_port3) || defined(__MSP430_HAS_PORT3__) || defined(__MSP430_HAS_PORT3_R__)
  Port30 = P30;
  Port31 = P31;
  Port32 = P32;
  Port33 = P33;
  Port34 = P34;
  Port35 = P35;
  Port36 = P36;
  Port37 = P37;
#endif

#if defined(__msp430_have_port4) || defined(__MSP430_HAS_PORT4__) || defined(__MSP430_HAS_PORT4_R__)
  Port40 = P40;
  Port41 = P41;
  Port42 = P42;
  Port43 = P43;
  Port44 = P44;
  Port45 = P45;
  Port46 = P46;
  Port47 = P47;
#endif
 
#if defined(__msp430_have_port5) || defined(__MSP430_HAS_PORT5__) || defined(__MSP430_HAS_PORT5_R__)
  Port50 = P50;
  Port51 = P51;
  Port52 = P52;
  Port53 = P53;
  Port54 = P54;
  Port55 = P55;
  Port56 = P56;
  Port57 = P57;
#endif

#if defined(__msp430_have_port6) || defined(__MSP430_HAS_PORT6__) || defined(__MSP430_HAS_PORT6_R__)
  Port60 = P60;
  Port61 = P61;
  Port62 = P62;
  Port63 = P63;
  Port64 = P64;
  Port65 = P65;
  Port66 = P66;
  Port67 = P67;
#endif
}
