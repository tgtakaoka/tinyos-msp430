#include "Timer.h"
#include "Timer-vlo.h"

configuration CounterMilliVlo16C
{
    provides interface Counter<TMilli,uint16_t>;
}
implementation
{
    components Msp430CounterVloC as CounterFrom;
    components new ApproximateCounterC(TMilli,uint16_t,TVlo,uint16_t,
                                       VLO_HZ/1000,uint32_t) as Transform;

    Counter = Transform.Counter;

    Transform.CounterFrom -> CounterFrom;
}
