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

generic module EnlargeCounterC(
    typedef precision_tag,
    typedef to_size_type @integer(),
    typedef from_size_type @integer()) @safe() {
    provides interface Counter<precision_tag, to_size_type> as Counter;
    uses interface Counter<precision_tag, from_size_type> as CounterFrom;
}
implementation {
    to_size_type m_upper;
    bool m_overflow;

    static const to_size_type upper_one() {
        return (to_size_type)1 << (sizeof(from_size_type) * 8);
    }

    async command to_size_type Counter.get() {
        atomic {
            to_size_type high = m_upper;
            from_size_type low = call CounterFrom.get();
            if (call CounterFrom.isOverflowPending()) {
                high += upper_one();
                low = call CounterFrom.get();
            }
            return high + low;
        }
    }

    async command bool Counter.isOverflowPending() {
        atomic {
            if (m_overflow)
                return TRUE;
            if (call CounterFrom.isOverflowPending()) {
                return m_upper + upper_one() == 0;
            }
            return FALSE;
        }
    }

    async command void Counter.clearOverflow() {
        atomic {
            m_overflow = FALSE;
            if (call Counter.isOverflowPending()) {
                call CounterFrom.clearOverflow();
                m_upper += upper_one();
            }
        }
    }

    async event void CounterFrom.overflow() {
        atomic {
            m_upper += upper_one();
            if (m_upper == 0)
                m_overflow = TRUE;
        }
    }
}
