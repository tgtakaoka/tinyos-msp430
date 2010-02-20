generic module VirtualizeTimer16C(typedef precision_tag, int max_timers) @safe()
{
    provides interface Timer16<precision_tag> as Timer[uint8_t num];
    uses interface Timer16<precision_tag> as TimerFrom;
}
implementation
{
    enum {
        NUM_TIMERS = max_timers,
        END_OF_LIST = 255,
    };

    typedef struct {
        uint16_t t0;
        uint16_t dt;
        bool isoneshot : 1;
        bool isrunning : 1;
        bool _reserved : 6;
    } Timer_t;

    Timer_t m_timers[NUM_TIMERS];
    bool m_timers_changed;

    task void updateFromTimer();

    void fireTimers(uint16_t now) {
        uint8_t num;

        for (num=0; num<NUM_TIMERS; num++) {
            Timer_t* timer = &m_timers[num];

            if (timer->isrunning) {
                uint16_t elapsed = now - timer->t0;

                if (elapsed >= timer->dt) {
                    if (timer->isoneshot)
                        timer->isrunning = FALSE;
                    else // Update timer for next event
                        timer->t0 += timer->dt;

                    signal Timer.fired[num]();
                    break;
                }
            }
        }
        post updateFromTimer();
    }
  
    task void updateFromTimer() {
        uint16_t now = call TimerFrom.getNow();
        int16_t min_remaining = (1UL << 15) - 1; /* max int16_t */
        bool min_remaining_isset = FALSE;
        uint8_t num;

        call TimerFrom.stop();

        for (num=0; num<NUM_TIMERS; num++) {
            Timer_t* timer = &m_timers[num];

            if (timer->isrunning) {
                uint16_t elapsed = now - timer->t0;
                int16_t remaining = timer->dt - elapsed;

                if (remaining < min_remaining) {
                    min_remaining = remaining;
                    min_remaining_isset = TRUE;
                }
            }
        }

        if (min_remaining_isset) {
            if (min_remaining <= 0)
                fireTimers(now);
            else
                call TimerFrom.startOneShotAt(now, min_remaining);
        }
    }
  
    event void TimerFrom.fired() {
        fireTimers(call TimerFrom.getNow());
    }

    void startTimer(uint8_t num, uint16_t t0, uint16_t dt, bool isoneshot) {
        Timer_t* timer = &m_timers[num];
        timer->t0 = t0;
        timer->dt = dt;
        timer->isoneshot = isoneshot;
        timer->isrunning = TRUE;
        post updateFromTimer();
    }

    command void Timer.startPeriodic[uint8_t num](uint16_t dt) {
        startTimer(num, call TimerFrom.getNow(), dt, FALSE);
    }

    command void Timer.startOneShot[uint8_t num](uint16_t dt) {
        startTimer(num, call TimerFrom.getNow(), dt, TRUE);
    }

    command void Timer.stop[uint8_t num]() {
        m_timers[num].isrunning = FALSE;
    }

    command bool Timer.isRunning[uint8_t num]() {
        return m_timers[num].isrunning;
    }

    command bool Timer.isOneShot[uint8_t num]() {
        return m_timers[num].isoneshot;
    }

    command void Timer.startPeriodicAt[uint8_t num](uint16_t t0, uint16_t dt) {
        startTimer(num, t0, dt, FALSE);
    }

    command void Timer.startOneShotAt[uint8_t num](uint16_t t0, uint16_t dt) {
        startTimer(num, t0, dt, TRUE);
    }

    command uint16_t Timer.getNow[uint8_t num]() {
        return call TimerFrom.getNow();
    }

    command uint16_t Timer.gett0[uint8_t num]() {
        return m_timers[num].t0;
    }

    command uint16_t Timer.getdt[uint8_t num]() {
        return m_timers[num].dt;
    }

    default event void Timer.fired[uint8_t num]() {
    }
}
