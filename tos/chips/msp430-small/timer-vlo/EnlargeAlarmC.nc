/* Copyright (c) 2018, Tadashi G. Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

generic module EnlargeAlarmC(
    typedef precision_tag,
    typedef to_size_type @integer(),
    typedef from_size_type @integer()) {
    provides interface Alarm<precision_tag,to_size_type>;
    uses {
        interface Counter<precision_tag,to_size_type>;
        interface Alarm<precision_tag,from_size_type> as AlarmFrom;
    }
}
implementation {
    to_size_type m_t0;
    to_size_type m_dt;

    enum {
        MAX_DELAY_LOG2 = 8 * sizeof(from_size_type) - 1,
        MAX_DELAY = ((to_size_type)1) << MAX_DELAY_LOG2,
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

        /* m_t0 is assumed to be in the past. If it's > now, we assume
           that time has wrapped around */

        to_size_type expires = m_t0 + m_dt;

        /* The cast is necessary to get correct wrap-around arithmetic */
        to_size_type remaining = (to_size_type)(expires - now);

        /* if (expires <= now) remaining = 0; in wrap-around arithmetic */
        if (m_t0 <= now) {
            if (expires >= m_t0 && // if it wraps, it's > now
                expires <= now)
                remaining = 0;
        } else {
            if (expires >= m_t0 || // didn't wrap so < now
                expires <= now)
                remaining = 0;
        }
        if (remaining > MAX_DELAY) {
            m_t0 = now + MAX_DELAY;
            m_dt = remaining - MAX_DELAY;
            remaining = MAX_DELAY;
        } else {
            m_t0 += m_dt;
            m_dt = 0;
        }
        call AlarmFrom.startAt((from_size_type)now,
                               (from_size_type)remaining);
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

    async event void Counter.overflow() {}

    default async event void Alarm.fired() {}
}
