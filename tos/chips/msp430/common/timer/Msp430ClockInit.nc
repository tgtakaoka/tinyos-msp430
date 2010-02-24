interface Msp430ClockInit
{
#if !defined(__MSP430_HAS_BC2__)
    event void setupDcoCalibrate();
#endif
    event void initClocks();
    event void initTimerA();
#if defined(__MSP430_HAS_T1A2__)
    event void initTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    event void initTimerB();
#endif

#if !defined(__MSP430_HAS_BC2__)
    command void defaultSetupDcoCalibrate();
#endif
    command void defaultInitClocks();
    command void defaultInitTimerA();
#if defined(__MSP430_HAS_T1A2__)
    command void defaultInitTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    command void defaultInitTimerB();
#endif
}
