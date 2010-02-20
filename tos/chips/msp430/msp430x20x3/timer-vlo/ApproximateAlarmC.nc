generic module ApproximateAlarmC(
    typedef to_precision_tag,
    typedef to_size_type @integer(),
    typedef from_precision_tag,
    typedef from_size_type @integer(),
    const uint16_t scale)
{
    provides interface Alarm<to_precision_tag,to_size_type>;
    uses interface Counter<to_precision_tag,to_size_type>;
    uses interface Alarm<from_precision_tag,from_size_type> as AlarmFrom;
}
implementation
{
    to_size_type m_t0;
    to_size_type m_dt;

    enum {
        MAX_FROM = (to_size_type)1 << (sizeof(from_size_type) * 8 - 1),
        MAX_DELAY = MAX_FROM / scale,
    };

    async command to_size_type Alarm.getNow() {
        return call Counter.get();
    }

    async command to_size_type Alarm.getAlarm() {
        atomic return m_t0 + m_dt;
    }

    async command bool Alarm.isRunning() {
        return call AlarmFrom.isRunning();
    }

    async command void Alarm.stop() {
        call AlarmFrom.stop();
    }

    void set_alarm() {
        to_size_type now = call Counter.get();
        to_size_type expires, remaining;

        expires = m_t0 + m_dt;
        remaining = (to_size_type)(expires - now);

        if (m_t0 <= now) {
            if (expires >= m_t0 && expires <= now)
                remaining = 0;
        } else {
            if (expires >= m_t0 || expires <= now)
                remaining = 0;
        }
        if (remaining >= MAX_DELAY) {
            m_t0 = now + MAX_DELAY;
            m_dt = remaining - MAX_DELAY;
            remaining = MAX_DELAY;
        } else {
            m_t0 += m_dt;
            m_dt = 0;
        }
        call AlarmFrom.startAt((from_size_type)(now * scale),
                               (from_size_type)(remaining * scale));

    }

    async command void Alarm.startAt(to_size_type t0, to_size_type dt) {
        atomic {
            m_t0 = t0;
            m_dt = dt;
            set_alarm();
        }
    }

    async command void Alarm.start(to_size_type dt) {
        call Alarm.startAt(call Alarm.getNow(), dt);
    }

    async event void AlarmFrom.fired() {
        atomic {
            if (m_dt == 0) {
                signal Alarm.fired();
            } else {
                set_alarm();
            }
        }
    }

    async event void Counter.overflow() {
    }

    default async event void Alarm.fired() {
    }
}
