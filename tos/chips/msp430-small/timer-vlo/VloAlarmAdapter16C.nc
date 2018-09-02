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

#include "Timer-vlo.h"

module VloAlarmAdapter16C {
    provides interface Alarm<TMilli,uint16_t>;
    uses {
        interface Counter<TMilli,uint16_t>;
        interface Alarm<TVlo,uint16_t> as AlarmFrom;
        interface Msp430VloCalibInfo as VloCalibInfo;
    }
}
implementation {
    uint16_t m_t0;
    uint16_t m_dt;

    enum {
        MAX_FROM = (uint16_t)1 << 15,
    };

    async command uint16_t Alarm.getNow() {
        return call Counter.get();
    }

    async command uint16_t Alarm.getAlarm() {
        atomic return m_t0 + m_dt;
    }

    async command bool Alarm.isRunning() {
        return call AlarmFrom.isRunning();
    }

    async command void Alarm.stop() {
        call AlarmFrom.stop();
    }

    void set_alarm() {
        const uint16_t scale = call VloCalibInfo.getVloFreqKiHz();
        const uint16_t MAX_DELAY = call VloCalibInfo.getMaxDelay();
        uint16_t now = call Counter.get();
        uint16_t expires = m_t0 + m_dt;
        uint16_t remaining = (uint16_t)(expires - now);

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
        call AlarmFrom.startAt((uint16_t)(now * scale),
                               (uint16_t)(remaining * scale));
    }

    async command void Alarm.startAt(uint16_t t0, uint16_t dt) {
        atomic {
            m_t0 = t0;
            m_dt = dt;
            set_alarm();
        }
    }

    async command void Alarm.start(uint16_t dt) {
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
