/*
 * Copyright (c) 2018 Tadashi G. Takaoka
 * Copyright (c) 2011 Eric B. Decker
 * Copyright (c) 2005 Stanford University.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
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
 * Implementation of TEP 112 (Microcontroller Power Management) for
 * the MSP430. Code for low power calculation copied from older
 * msp430hardware.h by Vlado Handziski, Joe Polastre, and Cory Sharp.
 *
 *
 * @author Philip Levis
 * @author Vlado Handziski
 * @author Joe Polastre
 * @author Cory Sharp
 * @author Eric B. Decker <cire831@gmail.com>
 * @author Tadashi G. Takaoka
 */

module McuSleepC @safe() {
  provides {
    interface McuSleep;
    interface McuPowerState;
  }
  uses {
    interface McuPowerOverride;
  }
}
implementation {
  bool dirty = TRUE;
  mcu_power_t powerState = MSP430_POWER_ACTIVE;

  /* Note that the power values are maintained in an order
   * based on their active components, NOT on their values.*/
  // NOTE: This table should be in progmem.
  const uint16_t msp430PowerBits[MSP430_POWER_LPM4 + 1] = {
    0,                                       // ACTIVE
    SR_CPUOFF,                               // LPM0
    SR_SCG0+SR_CPUOFF,                       // LPM1
    SR_SCG1+SR_CPUOFF,                       // LPM2
    SR_SCG1+SR_SCG0+SR_CPUOFF,               // LPM3
    SR_SCG1+SR_SCG0+SR_OSCOFF+SR_CPUOFF,     // LPM4
  };
    
  mcu_power_t getPowerState() {
    mcu_power_t pState = MSP430_POWER_LPM3;
    // TimerA, USCI check
    if ((((TACCTL0 & CCIE) || (TACCTL1 & CCIE)
#ifdef __MSP430_HAS_TA3__
	  || (TACCTL2 & CCIE)
#endif
		 ) &&
	 ((TACTL & TASSEL_3) == TASSEL_2))
#ifdef __MSP430_HAS_USCI__
	|| ((UCA0CTL1 & UCSSEL_3) != UCSSEL_0)
	|| ((UCB0CTL1 & UCSSEL_3) != UCSSEL_0)
#endif
#ifdef __MSP430_HAS_USCI_AB1__
	|| ((UCA1CTL1 & UCSSEL_3) != UCSSEL_0)
	|| ((UCB1CTL1 & UCSSEL_3) != UCSSEL_0)
#endif
	    )
      pState = MSP430_POWER_LPM1;

#if defined(__msp430_have_adc12) || defined(__MSP430_HAS_ADC12__)
    // ADC12 check, pre-condition: pState != MSP430_POWER_ACTIVE
    if (ADC12CTL0 & ADC12ON){
      if (ADC12CTL1 & ADC12SSEL_2){
        // sample or conversion operation with MCLK or SMCLK
        if (ADC12CTL1 & ADC12SSEL_1)
          pState = MSP430_POWER_LPM1;
        else
          pState = MSP430_POWER_ACTIVE;
      } else if ((ADC12CTL1 & SHS0) && ((TACTL & TASSEL_3) == TASSEL_2)){
        // Timer A is used as sample-and-hold source and SMCLK sources Timer A
        // (Timer A interrupts are always disabled when it is used by the 
        // ADC subsystem, that's why the Timer check above is not enough)
	      pState = MSP430_POWER_LPM1;
      }
    }
#endif

#if defined(__msp430_have_adc10) || defined(__MSP430_HAS_ADC10__)
    // ADC10 check, pre-condition: pState != MSP430_POWER_ACTIVE
    if (ADC10CTL0 & ADC10ON){
      if (ADC10CTL1 & ADC10SSEL_2){
        // sample or conversion operation with MCLK or SMCLK
        if (ADC10CTL1 & ADC10SSEL_1)
          pState = MSP430_POWER_LPM1;
        else
          pState = MSP430_POWER_ACTIVE;
      } else if ((ADC10CTL1 & SHS_3) && ((TACTL & TASSEL_3) == TASSEL_2)){
        // Timer A is used as sample-and-hold source and SMCLK sources Timer A
        // (Timer A interrupts are always disabled when it is used by the
        // ADC subsystem, that's why the Timer check above is not enough)
	      pState = MSP430_POWER_LPM1;
      }
    }
#endif
    return pState;
  }

  void computePowerState() {
    powerState = mcombine(getPowerState(),
			  call McuPowerOverride.lowestState());
  }

  async command void McuSleep.sleep() {
    uint16_t temp;
    if (dirty) {
      computePowerState();
      //dirty = 0;
    }
    temp = msp430PowerBits[powerState] | SR_GIE;
    __asm__ __volatile__( "bis  %0, r2" : : "m" (temp) );
    call McuSleep.irq_preamble();
    // All of memory may change at this point...
    asm volatile ("" : : : "memory");
    __nesc_disable_interrupt();
  }

  async command void McuSleep.irq_preamble()  { }
  async command void McuSleep.irq_postamble() { }

  async command void McuPowerState.update() {
    atomic dirty = 1;
  }

  default async command mcu_power_t McuPowerOverride.lowestState() {
    return MSP430_POWER_LPM4;
  }
}
