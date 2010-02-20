#include "Timer.h"

module Blink1SecC @safe()
{
    uses interface Timer<TMilli> as Timer;
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
        call Timer.startPeriodic(FLASH);
    }

    event void Timer.fired() {
        if (on) {
            call Timer.startPeriodic(CYCLE - FLASH);
        } else {
            call Timer.startPeriodic(FLASH);
        }
        call Leds.led0Toggle();
        on = !on;
    }
}

