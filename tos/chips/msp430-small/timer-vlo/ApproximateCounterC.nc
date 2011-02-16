/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G. Takaoka
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

generic module ApproximateCounterC(
    typedef to_precision_tag,
    typedef to_size_type @integer(),
    typedef from_precision_tag,
    typedef from_size_type @integer(),
    uint16_t scale,
    typedef upper_count_type @integer()) @safe()
{
    provides interface Counter<to_precision_tag,to_size_type> as Counter;
    uses interface Counter<from_precision_tag,from_size_type> as CounterFrom;
}
implementation
{
    upper_count_type m_upper;
    to_size_type m_high;

    async command to_size_type Counter.get() {
        to_size_type rv = 0;
        atomic {
            upper_count_type high = m_upper;
            from_size_type low = call CounterFrom.get();
            if (call CounterFrom.isOverflowPending()) {
                high++;
                low = call CounterFrom.get();
            }
            rv = (((upper_count_type)high << (8 * sizeof(from_size_type)))
                  + low) / scale;
            if (sizeof(to_size_type) > sizeof(from_size_type))
                rv += m_high;
            return rv;
        }
    }

    async command bool Counter.isOverflowPending() {
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
        atomic {
            m_upper++;
            if (m_upper >= scale) {
                m_upper = 0;
                if (sizeof(to_size_type) > sizeof(from_size_type))
                    m_high += (to_size_type)1 << (8 * sizeof(from_size_type));
                if (m_high == 0)
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
