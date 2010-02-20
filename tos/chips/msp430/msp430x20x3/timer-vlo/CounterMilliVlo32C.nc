#include "Timer.h"

configuration CounterMilliVlo32C
{
    provides interface Counter<TMilli,uint32_t>;
}
implementation
{
    components Msp430CounterVloC as CounterFrom;
    components new ApproximateCounterC(TMilli,uint32_t,TVlo,uint16_t,
                                       VLO_HZ/1000,uint32_t) as Transform;

    Counter = Transform.Counter;

    Transform.CounterFrom -> CounterFrom;
}
