configuration Msp430Counter32khzC
{
    provides interface Counter<T32khz,uint16_t> as Msp430Counter32khz;
}
implementation
{
    components Msp430TimerC;
    components new Msp430CounterC(T32khz) as Counter;

    Msp430Counter32khz = Counter;
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    Counter.Msp430Timer -> Msp430TimerC.TimerB;
#else
    Counter.Msp430Timer -> Msp430TimerC.TimerA;
#endif
}
