configuration Msp430CounterVloC
{
    provides interface Counter<TVlo,uint16_t> as Msp430CounterVlo;
}
implementation
{
    components Msp430TimerC;
    components new Msp430CounterC(TVlo) as Counter;

    Msp430CounterVlo = Counter;
    Counter.Msp430Timer -> Msp430TimerC.TimerA;
}
