#include "Timer.h"

generic configuration AlarmMilliVlo32C()
{
    provides interface Init;
    provides interface Alarm<TMilli,uint32_t>;
}
implementation
{
    components new AlarmVlo16C() as AlarmFrom;
    components CounterMilliVlo32C as Counter;
    components new ApproximateAlarmC(TMilli,uint32_t,TVlo,uint16_t,
                                     VLO_HZ/1000) as Transform;

    Init = AlarmFrom;
    Alarm = Transform;

    Transform.AlarmFrom -> AlarmFrom;
    Transform.Counter -> Counter;
}
