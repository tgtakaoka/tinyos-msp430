/* -*- mode: c; mode: flyspell-prog; -*- */
/*
 * Copyright (C) 2010 Tadashi G. Takaoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
