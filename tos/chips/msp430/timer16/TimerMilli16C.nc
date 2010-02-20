#include "Timer.h"
#include "Timer16.h"

generic configuration TimerMilli16C()
{
    provides interface Timer16<TMilli>;
}
implementation
{
    components TimerMilli16P;
    Timer16 = TimerMilli16P.TimerMilli16[unique(UQ_TIMER_MILLI16)];
}
