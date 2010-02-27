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
#if defined(TIMERA0_VECTOR)
    TOSH_SIGNAL(TIMERA0_VECTOR) {
        signal VectorTimerA0.fired();
    }
#elif defined(TIMER0_A0_VECTOR)
    TOSH_SIGNAL(TIMER0_A0_VECTOR) {
        signal VectorTimerA0.fired();
    }
#endif

#if defined(TIMERA1_VECTOR)
    TOSH_SIGNAL(TIMERA1_VECTOR) {
        signal VectorTimerA1.fired();
    }
#elif defined(TIMER0_A1_VECTOR)
    TOSH_SIGNAL(TIMER0_A1_VECTOR) {
        signal VectorTimerA1.fired();
    }
#endif

#if defined(__MSP430_HAS_T1A2__)
    TOSH_SIGNAL(TIMER1_A0_VECTOR) {
        signal VectorTimer1A0.fired();
    }

    TOSH_SIGNAL(TIMER1_A1_VECTOR) {
        signal VectorTimer1A1.fired();
    }
#endif

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    TOSH_SIGNAL(TIMERB0_VECTOR) {
        signal VectorTimerB0.fired();
    }

    TOSH_SIGNAL(TIMERB1_VECTOR) {
        signal VectorTimerB1.fired();
    }
#endif
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
