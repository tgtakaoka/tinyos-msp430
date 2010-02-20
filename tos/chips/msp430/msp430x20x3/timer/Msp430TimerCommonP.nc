module Msp430TimerCommonP @safe()
{
    provides interface Msp430TimerEvent as VectorTimerA0;
    provides interface Msp430TimerEvent as VectorTimerA1;
}
implementation
{
    TOSH_SIGNAL(TIMERA0_VECTOR) {
        signal VectorTimerA0.fired();
    }
    TOSH_SIGNAL(TIMERA1_VECTOR) {
        signal VectorTimerA1.fired();
    }
}
