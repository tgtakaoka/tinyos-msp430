//$Id: Msp430ClockP.nc,v 1.9 2010-06-29 22:07:45 scipio Exp $

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
 * - Neither the name of the copyright holders nor the names of
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
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 * @author Vlado Handziski <handzisk@tkn.tu-berlind.de>
 */

#include <Msp430DcoSpec.h>

#include "Msp430Timer.h"

module Msp430ClockP @safe()
{
  provides interface Init;
  provides interface Msp430ClockInit;
  provides interface McuPowerOverride;
}
implementation
{
  MSP430REG_NORACE(IE1);
  MSP430REG_NORACE(TACTL);
  MSP430REG_NORACE(TAIV);
#if defined(__MSP430_HAS_T1A2__)
  MSP430REG_NORACE(TA1CTL);
  MSP430REG_NORACE(TA1IV);
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  MSP430REG_NORACE(TBCTL);
  MSP430REG_NORACE(TBIV);
#endif

  enum
  {
    ACLK_CALIB_PERIOD = 8,
    TARGET_DCO_DELTA = (TARGET_DCO_KHZ / ACLK_KHZ) * ACLK_CALIB_PERIOD,
  };

  async command mcu_power_t McuPowerOverride.lowestState() {
    return MSP430_POWER_LPM3;
  }

  command void Msp430ClockInit.defaultSetupDcoCalibrate()
  {
#if !defined(__MSP430_HAS_BC2__)
  
    // --- setup ---

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    TACTL = TASSEL1 | MC1; // source SMCLK, continuous mode, everything else 0
    TBCTL = TBSSEL0 | MC1;
    BCSCTL1 = XT2OFF | RSEL2;
    BCSCTL2 = 0;
    TBCCTL0 = CM0;
#else
    TACTL = TASSEL_1 | ID_0 | MC_2 | TACLR;  // source ACLK, continuous mode
    BCSCTL1 = XT2OFF;                        // LF mode, ACLK=LFXT1CLK/1
    BCSCTL2 = SELM_0 | DIVM_0 | DIVS_0 /* | DCOR */;
#endif
#endif /* __MSP430_HAS_BC2__ */
   }
    
  command void Msp430ClockInit.defaultInitClocks()
  {
#if !defined(__MSP430_HAS_BC2__)
    // BCSCTL1
    // .XT2OFF = 1; disable the external oscillator for SCLK and MCLK
    // .XTS = 0; set low frequency mode for LXFT1
    // .DIVA = 0; set the divisor on ACLK to 1
    // .RSEL, do not modify
    BCSCTL1 = XT2OFF | (BCSCTL1 & (RSEL2|RSEL1|RSEL0));

    // BCSCTL2
    // .SELM = 0; select DCOCLK as source for MCLK
    // .DIVM = 0; set the divisor of MCLK to 1
    // .SELS = 0; select DCOCLK as source for SCLK
    // .DIVS = 2; set the divisor of SCLK to 4
    // .DCOR = 0; select internal resistor for DCO
    BCSCTL2 = DIVS1;
#else /* __MSP430_HAS_BC2__ */
    P2SEL |= 0xc0;                      // P2.6=XIN, P2.7=XOUT
    P2DIR = 0x80 | (P2DIR & ~0xc0);     // some chips need P2.7 set as output

#if defined(CALBC1_16MHZ_)
#if defined(__msp430_using_vlo)
    BCSCTL1 = CALBC1_16MHZ;             // DCO=16MHZ, ACLK=VLO/1
#else
    BCSCTL1 = CALBC1_16MHZ | DIVA_0;    // DCO=16MHZ, ACLK/1
#endif
    DCOCTL = CALDCO_16MHZ;
#elif defined(CALBC1_1MHZ_)
#if defined(__msp430_using_vlo)
    BCSCTL1 = CALBC1_1MHZ;              // DCO=1MHZ, ACLK=VLO/1
#else
    BCSCTL1 = CALBC1_1MHZ | DIVA_0;     // DCO=1MHZ, ACLK/1
#endif
    DCOCTL = CALDCO_1MHZ;
#else
#error "no DCO calibration value found"
#endif
#if defined(__msp430_using_vlo)
    BCSCTL2 = SELM_0 | DIVM_0 | SELS | DIVS_0; // MCLK=DCO/1, SMCLK=VLO/1
    BCSCTL3 = LFXT1S_2;                        // ACLK=VLO
#else
    BCSCTL2 = SELM_0 | DIVM_0 | DIVS_3; // MCLK=DCO/1, SMCLK=MCLK/8
#if defined(ERRATA_XOSC8)
    BCSCTL3 = LFXT1S_0 | XCAP_3;        // ACLK=32kHz, CL,eff=12.5pF
#else
    BCSCTL3 = LFXT1S_0 | XCAP_2;        // ACLK=32kHz, CL,eff=10pF
#endif
#endif
#endif /* __MSP430_HAS_BC2__ */

    // IE1.OFIE = 0; no interrupt for oscillator fault
    CLR_FLAG( IE1, OFIE );
  }

  command void Msp430ClockInit.defaultInitTimerA()
  {
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    TAR = 0;

    // TACTL
    // .TACLGRP = 0; each TACL group latched independently
    // .CNTL = 0; 16-bit counter
    // .TASSEL = 2; source SMCLK = DCO/4
    // .ID = 0; input divisor of 1
    // .MC = 0; initially disabled
    // .TACLR = 0; reset timer A
    // .TAIE = 1; enable timer A interrupts
    TACTL = TASSEL1 | TAIE;
#elif defined(__msp430_using_vlo)
    TACTL = TASSEL_1 | ID_0 | MC_2 | TAIE | TACLR;
    // ACLK/1 ~ 12kHz, Continuous mode
#else
    TACTL = TASSEL_1 | ID_0 | MC_2 | TAIE | TACLR;
    // ACLK/1=32kHz, Continuous mode
#endif
  }

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  command void Msp430ClockInit.defaultInitTimerB()
  {
    TBR = 0;

    // TBCTL
    // .TBCLGRP = 0; each TBCL group latched independently
    // .CNTL = 0; 16-bit counter
    // .TBSSEL = 1; source ACLK
    // .ID = 0; input divisor of 1
    // .MC = 0; initially disabled
    // .TBCLR = 0; reset timer B
    // .TBIE = 1; enable timer B interrupts
    TBCTL = TBSSEL0 | TBIE;
  }
#endif

  default event void Msp430ClockInit.setupDcoCalibrate()
  {
    call Msp430ClockInit.defaultSetupDcoCalibrate();
  }
  
  default event void Msp430ClockInit.initClocks()
  {
    call Msp430ClockInit.defaultInitClocks();
  }

  default event void Msp430ClockInit.initTimerA()
  {
    call Msp430ClockInit.defaultInitTimerA();
  }

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  default event void Msp430ClockInit.initTimerB()
  {
    call Msp430ClockInit.defaultInitTimerB();
  }
#endif


  void startTimerA()
  {
    // TACTL.MC = 2; continuous mode
    TACTL = MC1 | (TACTL & ~(MC1|MC0));
#if defined(__MSP430_HAS_T1A2__)
    // TA1CTL.MC = 2; continuous mode
    TA1CTL = MC1 | (TA1CTL & ~(MC1|MC0));
#endif
  }

  void stopTimerA()
  {
    //TACTL.MC = 0; stop timer B
    TACTL = TACTL & ~(MC1|MC0);
#if defined(__MSP430_HAS_T1A2__)
    //TA1CTL.MC = 0; stop timer A
    TA1CTL &= ~(MC1|MC0);
#endif
  }

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  void startTimerB()
  {
    // TBCTL.MC = 2; continuous mode
    TBCTL = MC1 | (TBCTL & ~(MC1|MC0));
  }

  void stopTimerB()
  {
    //TBCTL.MC = 0; stop timer B
    TBCTL = TBCTL & ~(MC1|MC0);
  }
#endif

#if !defined(__MSP430_HAS_BC2__)
  void set_dco_calib( int calib )
  {
    BCSCTL1 = (BCSCTL1 & ~0x07) | ((calib >> 8) & 0x07);
    DCOCTL = calib & 0xff;
  }

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  uint16_t test_calib_busywait_delta( int calib )
  {
    int8_t aclk_count = 2;
    uint16_t dco_prev = 0;
    uint16_t dco_curr = 0;

    set_dco_calib( calib );

    while( aclk_count-- > 0 )
    {
      TBCCR0 = TBR + ACLK_CALIB_PERIOD; // set next interrupt
      TBCCTL0 &= ~CCIFG; // clear pending interrupt
      while( (TBCCTL0 & CCIFG) == 0 ); // busy wait
      dco_prev = dco_curr;
      dco_curr = TAR;
    }

    return dco_curr - dco_prev;
  }
#else /* defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__) */
  void delay_10n(uint16_t n) {
    do {
      __asm__ __volatile__ ("nop");     // 1 cycle
      __asm__ __volatile__ ("jmp $+2"); // 2 cycles
      __asm__ __volatile__ ("jmp $+2"); // 2 cycles
      __asm__ __volatile__ ("jmp $+2"); // 2 cycles
    } while (--n != 0);                 // add, jnz: (1+2)=3 cycles
  }

  uint16_t calib_using_timera(int calib, uint16_t dco_khz) {
    set_dco_calib(calib);
    TACTL |= TACLR;         // clear TAR
    delay_10n(dco_khz);
    return TAR;
  }
#endif /* defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__) */

  // busyCalibrateDCO
  // Should take about 9ms if ACLK_CALIB_PERIOD=8.
  // DCOCTL and BCSCTL1 are calibrated when done.
  void busyCalibrateDco()
  {
    // --- variables ---
    int calib;
    int step;

    // --- calibrate ---

    // Binary search for RSEL,DCO,DCOMOD.
    // It's okay that RSEL isn't monotonic.

    for( calib=0,step=0x800; step!=0; step>>=1 )
    {
      // if the step is not past the target, commit it
      if( test_calib_busywait_delta(calib|step) <= TARGET_DCO_DELTA )
        calib |= step;
    }

    // if DCOx is 7 (0x0e0 in calib), then the 5-bit MODx is not useable, set it to 0
    if( (calib & 0x0e0) == 0x0e0 )
      calib &= ~0x01f;

    set_dco_calib( calib );
  }
#endif /* defined(__MSP430_HAS_BC2__) */

  command error_t Init.init()
  {
    // Reset timers and clear interrupt vectors
    TACTL = TACLR;
    TAIV = 0;
#if defined(__MSP430_HAS_T1A2__)
    TA1CTL = TACLR;
    TA1IV = 0;
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    TBCTL = TBCLR;
    TBIV = 0;
#endif

    atomic
    {
      signal Msp430ClockInit.setupDcoCalibrate();
#if !defined(__MSP430_HAS_BC2__)
      busyCalibrateDco();
#endif
      signal Msp430ClockInit.initClocks();
      signal Msp430ClockInit.initTimerA();
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
      signal Msp430ClockInit.initTimerB();
#endif
      startTimerA();
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
      startTimerB();
#endif
    }

    return SUCCESS;
  }
}

