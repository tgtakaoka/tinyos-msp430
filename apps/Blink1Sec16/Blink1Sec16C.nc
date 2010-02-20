#include "Timer.h"

module Blink1Sec16C @safe()
{
    uses interface Timer16<TMilli> as Timer16;
    uses interface Leds;
    uses interface Boot;
}
implementation
{
    enum {
        CYCLE = 1000,
        FLASH = 200,
    };
    bool on = TRUE;
    
    event void Boot.booted() {
        call Leds.led0On();
        call Timer16.startPeriodic(FLASH);
    }

    event void Timer16.fired() {
        if (on) {
            call Timer16.startPeriodic(CYCLE - FLASH);
        } else {
            call Timer16.startPeriodic(FLASH);
        }
        call Leds.led0Toggle();
        on = !on;
    }
}

