/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2010-2011, Tadashi G. Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "Msp430DcoSpec.h"

module PlatformClockVloP {
    uses {
        interface Msp430ClockInit;
        interface Msp430DcoCalib as DcoCalib;
        interface Msp430VloCalib as VloCalib;
    }
}
implementation {
    enum {
        SMCLK_DIVS =
#if   SMCLK_DIV == 1
        DIVS_0
#elif SMCLK_DIV == 2
        DIVS_1
#elif SMCLK_DIV == 4
        DIVS_2
#elif SMCLK_DIV == 8
        DIVS_3
#else
#error "PlatformVloP: unknown SMCLK_DIV defined.  Need valid SMCLK_DIV to proceed."
#endif
        ,
    };

    event void Msp430ClockInit.initClocks() {
        call DcoCalib.busyWaitCalibrateDco();
        call VloCalib.busyWaitCalibrateVlo();

        // call Msp430ClockInit.defaultInitClocks();
        // BCSCTL2
        // .SELM = 0;	select DCOCLK as source for MCLK
        // .DIVM = 0;	set the divisor of MCLK to 1
        // .SELS = 0;	select DCOCLK as source for SMCLK
        // .DIVS = xxx;	set the divisor of SCLK to SMCLK_DIVS
        // .DCOR = 0;	select internal resistor for DCO
        BCSCTL2 = SMCLK_DIVS;
        BCSCTL3 = LFXT1S_2;                        // ACLK=VLO

        // IE1.OFIE = 0; no interrupt for oscillator fault
        CLR_FLAG( IE1, OFIE );
    }

    event void Msp430ClockInit.initTimerMicro() {
        call Msp430ClockInit.defaultInitTimerMicro();
    }

    event void Msp430ClockInit.initTimerMilli() {
        call Msp430ClockInit.defaultInitTimerMilli();
    }
}
