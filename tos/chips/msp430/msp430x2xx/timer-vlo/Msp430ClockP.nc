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
#if defined(__MSP430_HAS_TB3__)
    MSP430REG_NORACE(TBCTL);
    MSP430REG_NORACE(TBIV);
#endif

    async command mcu_power_t McuPowerOverride.lowestState() {
        return MSP430_POWER_LPM3;
    }

    command void Msp430ClockInit.defaultInitClocks() {
        BCSCTL1 = CALBC1_16MHZ; // DCO=16MHZ, ACLK=VLO/1
        DCOCTL = CALDCO_16MHZ;
        BCSCTL2 = SELM_0 | DIVM_0 | SELS | DIVS_0; // MCLK=DCO/1, SMCLK=VLO/1
        BCSCTL3 = LFXT1S_2;                        // ACLK=VLO

        // IE1.OFIE = 0; no interrupt for oscillator fault
        CLR_FLAG( IE1, OFIE );
    }

    command void Msp430ClockInit.defaultInitTimerA() {
        TACTL = TASSEL_1 | ID_0 | MC_2 | TAIE | TACLR;
        // ACLK/1 ~ 12kHz, Continuous mode
    }

    default event void Msp430ClockInit.initClocks() {
        call Msp430ClockInit.defaultInitClocks();
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
#if defined(__MSP430_HAS_TB3__)
        TBCTL = TBCLR;
        TBIV = 0;
#endif

        atomic {
            signal Msp430ClockInit.initClocks();
            signal Msp430ClockInit.initTimerA();
#if defined(__MSP430_HAS_TB3__)
            signal Msp430ClockInit.initTimerB();
#endif
            startTimerA();
#if defined(__MSP430_HAS_TB3__)
            startTimerB();
#endif
        }

        return SUCCESS;
    }
}
