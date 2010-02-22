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
#if defined(__MSP430_HAS_TB3__)
    MSP430REG_NORACE(TBCTL);
    MSP430REG_NORACE(TBIV);
#endif

    async command mcu_power_t McuPowerOverride.lowestState() {
        return MSP430_POWER_LPM3;
    }

    command void Msp430ClockInit.defaultInitClocks() {
        P2SEL |= 0xc0;          // P2.6=XIN, P2.7=XOUT

        BCSCTL1 = CALBC1_16MHZ | DIVA_0;    // DCO=16MHZ, ACLK/1
        DCOCTL = CALDCO_16MHZ;
        BCSCTL2 = SELM_0 | DIVM_0 | DIVS_3; // MCLK=DCO/1, SMCLK=MCLK/8
#if defined(ERRATA_XOSC8)
        BCSCTL3 = LFXT1S_0 | XCAP_3;        // ACLK=32kHz, CL,eff=12.5pF
#else
        BCSCTL3 = LFXT1S_0 | XCAP_2;        // ACLK=32kHz, CL,eff=10pF
#endif

        // IE1.OFIE = 0; no interrupt for oscillator fault
        CLR_FLAG( IE1, OFIE );
    }

    default event void Msp430ClockInit.initClocks() {
        call Msp430ClockInit.defaultInitClocks();
    }

    command void Msp430ClockInit.defaultInitTimerA() {
        TACTL = TASSEL_1 | ID_0 | MC_2 | TAIE | TACLR;
        // ACLK/1=32kHz, Continuous mode
    }

    default event void Msp430ClockInit.initTimerA() {
        call Msp430ClockInit.defaultInitTimerA();
    }

    void startTimerA() {
        // TACTL.MC = 2; continuous mode
        TACTL = MC1 | (TACTL & ~(MC1|MC0));
    }

    void stopTimerA() {
        //TACTL.MC = 0; stop timer A
        TACTL &= ~(MC1|MC0);
    }

#if defined(__MSP430_HAS_T1A2__)
    command void Msp430ClockInit.defaultInitTimer1A() {
        TA1CTL = TASSEL_1 | ID_0 | MC_2 | TAIE | TACLR;
        // ACLK/1=32kHz, Continuous mode
    }

    default event void Msp430ClockInit.initTimer1A() {
        call Msp430ClockInit.defaultInitTimer1A();
    }

    void startTimer1A() {
        // TA1CTL.MC = 2; continuous mode
        TA1CTL = MC1 | (TA1CTL & ~(MC1|MC0));
    }

    void stopTimer1A() {
        //TA1CTL.MC = 0; stop timer A
        TA1CTL &= ~(MC1|MC0);
    }
#endif

#if defined(__MSP430_HAS_TB3__)
    command void Msp430ClockInit.defaultInitTimerB() {
        // TODO
    }

    default event void Msp430ClockInit.initTimerB() {
        call Msp430ClockInit.defaultInitTimerB();
    }

    void startTimerB() {
        // TODO 
    }

    void stopTimerB() {
        // TODO
    }
#endif

    command error_t Init.init() {
        // Reset timers and clear interrupt vectors
        TACTL = TACLR;
        TAIV = 0;
#if defined(__MSP430_HAS_T1A2__)
        TA1CTL = TACLR;
        TA1IV = 0;
#endif
#if defined(__MSP430_HAS_TB3__)
        TBCTL = TBCLR;
        TBIV = 0;
#endif

        atomic {
            signal Msp430ClockInit.initClocks();
            signal Msp430ClockInit.initTimerA();
#if defined(__MSP430_HAS_T1A2__)
            signal Msp430ClockInit.initTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__)
            signal Msp430ClockInit.initTimerB();
#endif
            startTimerA();
#if defined(__MSP430_HAS_T1A2__)
            startTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__)
            startTimerB();
#endif
        }

        return SUCCESS;
    }
}
