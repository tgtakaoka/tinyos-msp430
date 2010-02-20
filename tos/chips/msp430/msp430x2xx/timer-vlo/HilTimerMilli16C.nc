#include "Timer.h"
#include "Timer-vlo.h"

configuration HilTimerMilli16C {
    provides interface Init;
    provides interface Timer16<TMilli> as TimerMilli16[uint8_t num];
}
implementation
{
    components new AlarmMilliVlo16C() as AlarmMilliC;
    components new AlarmToTimer16C(TMilli);
    components new VirtualizeTimer16C(TMilli,uniqueCount(UQ_TIMER_MILLI16));

    Init = AlarmMilliC;
    TimerMilli16 = VirtualizeTimer16C;

    VirtualizeTimer16C.TimerFrom -> AlarmToTimer16C;
    AlarmToTimer16C.Alarm -> AlarmMilliC;
}
