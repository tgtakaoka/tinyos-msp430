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
