#include "Timer.h"
#include "Timer-vlo.h"

generic configuration AlarmMilliVlo16C()
{
    provides interface Init;
    provides interface Alarm<TMilli,uint16_t>;
}
implementation
{
    components new AlarmVlo16C() as AlarmFrom;
    components CounterMilliVlo16C as Counter;
    components new ApproximateAlarmC(TMilli,uint16_t,TVlo,uint16_t,
                                     VLO_HZ/1000) as Transform;

    Init = AlarmFrom;
    Alarm = Transform;

    Transform.AlarmFrom -> AlarmFrom;
    Transform.Counter -> Counter;
}
