#include "Timer.h"
#include "Timer16.h"

configuration TimerMilli16P
{
    provides interface Timer16<TMilli> as TimerMilli16[uint8_t id];
}
implementation
{
    components HilTimerMilli16C, MainC;
    MainC.SoftwareInit -> HilTimerMilli16C;
    TimerMilli16 = HilTimerMilli16C;
}
