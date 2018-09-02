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

module VloCounterAdapter16C {
    provides interface Counter<TMilli,uint16_t> as Counter;
    uses {
        interface Counter<TVlo,uint16_t> as CounterFrom;
        interface Msp430VloCalibInfo as VloCalibInfo;
    }
}
implementation {
    uint16_t m_upper;
    uint16_t m_high;
    uint16_t m_low;
    uint16_t m_prev;

    async command uint16_t Counter.get() {
        atomic {
            uint16_t high = m_upper;
            uint16_t low = call CounterFrom.get();
            if (call CounterFrom.isOverflowPending()) {
                high++;
                low = call CounterFrom.get();
            }
            if (low == m_low && high == m_high) {
                return m_prev;
            }
            m_low = low;
            m_high = high;
            m_prev = (((uint32_t)high << 16) + low) /
                call VloCalibInfo.getVloFreqKiHz();
            return m_prev;
        }
    }

    async command bool Counter.isOverflowPending() {
        const uint16_t scale = call VloCalibInfo.getVloFreqKiHz();
        return m_upper >= scale && call CounterFrom.isOverflowPending();
    }

    async command void Counter.clearOverflow() {
        atomic {
            if (call Counter.isOverflowPending()) {
                m_upper++;
                call CounterFrom.clearOverflow();
            }
        }
    }

    async event void CounterFrom.overflow() {
        const uint16_t scale = call VloCalibInfo.getVloFreqKiHz();
        atomic {
            m_upper++;
            if (m_upper >= scale) {
                m_upper = 0;
                signal Counter.overflow();
            }
        }
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
