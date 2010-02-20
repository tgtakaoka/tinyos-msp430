#include "Timer.h"
#include "Timer16.h"

generic module AlarmToTimer16C(typedef precision_tag) @safe()
{
    provides interface Timer16<precision_tag> as Timer;
    uses interface Alarm<precision_tag,uint16_t>;
}
implementation
{
    uint16_t m_dt;
    bool m_oneshot;

    void start(uint16_t t0, uint16_t dt, bool oneshot) {
        m_dt = dt;
        m_oneshot = oneshot;
        call Alarm.startAt(t0, dt);
    }

    command void Timer.startPeriodic(uint16_t dt)
    { start(call Alarm.getNow(), dt, FALSE); }

    command void Timer.startOneShot(uint16_t dt)
    { start(call Alarm.getNow(), dt, TRUE); }

    command void Timer.stop()
    { call Alarm.stop(); }

    task void fired() { 
        if(m_oneshot == FALSE)
            start(call Alarm.getAlarm(), m_dt, FALSE);
        signal Timer.fired();
    }

    async event void Alarm.fired()
    { post fired(); }

    command bool Timer.isRunning()
    { return call Alarm.isRunning(); }

    command bool Timer.isOneShot()
    { return m_oneshot; }

    command void Timer.startPeriodicAt(uint16_t t0, uint16_t dt)
    { start(t0, dt, FALSE); }

    command void Timer.startOneShotAt(uint16_t t0, uint16_t dt)
    { start(t0, dt, TRUE); }

    command uint16_t Timer.getNow()
    { return call Alarm.getNow(); }

    command uint16_t Timer.gett0()
    { return call Alarm.getAlarm() - m_dt; }

    command uint16_t Timer.getdt()
    { return m_dt; }
}
