#include "Timer.h"
#include "Timer16.h"

interface Timer16<precision_tag>
{
    command void startPeriodic(uint16_t dt);
    command void startOneShot(uint16_t dt);
    command void stop();
    event void fired();
    command bool isRunning();
    command bool isOneShot();
    command void startPeriodicAt(uint16_t t0, uint16_t dt);
    command void startOneShotAt(uint16_t t0, uint16_t dt);
    command uint16_t getNow();
    command uint16_t gett0();
    command uint16_t getdt();
}
