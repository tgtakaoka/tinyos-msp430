
module Msp430TimerCommonP @safe()
{
  provides interface Msp430TimerEvent as VectorTimerA0;
  provides interface Msp430TimerEvent as VectorTimerA1;
#if defined(__MSP430_HAS_T1A2__)
  provides interface Msp430TimerEvent as VectorTimer1A0;
  provides interface Msp430TimerEvent as VectorTimer1A1;
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  provides interface Msp430TimerEvent as VectorTimerB0;
  provides interface Msp430TimerEvent as VectorTimerB1;
#endif
}
implementation
{
#if defined(__MSP430_HAS_T1A2__)
#define TIMERA0_VECTOR TIMER0_A0_VECTOR
#define TIMERA1_VECTOR TIMER0_A1_VECTOR
#endif
  TOSH_SIGNAL(TIMERA0_VECTOR) { signal VectorTimerA0.fired(); }
  TOSH_SIGNAL(TIMERA1_VECTOR) { signal VectorTimerA1.fired(); }
#if defined(__MSP430_HAS_T1A2__)
  TOSH_SIGNAL(TIMER1_A0_VECTOR) { signal VectorTimer1A0.fired(); }
  TOSH_SIGNAL(TIMER1_A1_VECTOR) { signal VectorTimer1A1.fired(); }
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  TOSH_SIGNAL(TIMERB0_VECTOR) { signal VectorTimerB0.fired(); }
  TOSH_SIGNAL(TIMERB1_VECTOR) { signal VectorTimerB1.fired(); }
#endif
}

