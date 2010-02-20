configuration HilTimerMilliC
{
    provides interface Init;
    provides interface Timer<TMilli> as TimerMilli[uint8_t num];
    provides interface LocalTime<TMilli>;
}
implementation
{
    components new AlarmMilliVlo32C() as AlarmMilliC;
    components new AlarmToTimerC(TMilli);
    components new VirtualizeTimerC(TMilli,uniqueCount(UQ_TIMER_MILLI));
    components new CounterToLocalTimeC(TMilli);
    components CounterMilliVlo32C as CounterMilliC;

    Init = AlarmMilliC;
    TimerMilli = VirtualizeTimerC;
    LocalTime = CounterToLocalTimeC;

    VirtualizeTimerC.TimerFrom -> AlarmToTimerC;
    AlarmToTimerC.Alarm -> AlarmMilliC;
    CounterToLocalTimeC.Counter -> CounterMilliC;
}
