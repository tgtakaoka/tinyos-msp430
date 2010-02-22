interface Msp430ClockInit
{
    event void initClocks();
    command void defaultInitClocks();

    event void initTimerA();
    command void defaultInitTimerA();

#if defined(__MSP430_HAS_T1A2__)
    event void initTimer1A();
    command void defaultInitTimer1A();
#endif

#if defined(__MSP430_HAS_TB3__)
    event void initTimerB();
    command void defaultInitTimerB();
#endif
}

