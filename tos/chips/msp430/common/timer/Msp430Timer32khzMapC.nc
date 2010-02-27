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

configuration Msp430Timer32khzMapC
{
    provides interface Msp430Timer[uint8_t id];
    provides interface Msp430TimerControl[uint8_t id];
    provides interface Msp430Compare[uint8_t id];
}
implementation
{
    components Msp430TimerC;

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    Msp430Timer[0] = Msp430TimerC.TimerB;
    Msp430TimerControl[0] = Msp430TimerC.ControlB0;
    Msp430Compare[0] = Msp430TimerC.CompareB0;

    Msp430Timer[1] = Msp430TimerC.TimerB;
    Msp430TimerControl[1] = Msp430TimerC.ControlB1;
    Msp430Compare[1] = Msp430TimerC.CompareB1;

    Msp430Timer[2] = Msp430TimerC.TimerB;
    Msp430TimerControl[2] = Msp430TimerC.ControlB2;
    Msp430Compare[2] = Msp430TimerC.CompareB2;

#if defined(__MSP430_HAS_TB7__)
    Msp430Timer[3] = Msp430TimerC.TimerB;
    Msp430TimerControl[3] = Msp430TimerC.ControlB3;
    Msp430Compare[3] = Msp430TimerC.CompareB3;

    Msp430Timer[4] = Msp430TimerC.TimerB;
    Msp430TimerControl[4] = Msp430TimerC.ControlB4;
    Msp430Compare[4] = Msp430TimerC.CompareB4;

    Msp430Timer[5] = Msp430TimerC.TimerB;
    Msp430TimerControl[5] = Msp430TimerC.ControlB5;
    Msp430Compare[5] = Msp430TimerC.CompareB5;

    Msp430Timer[6] = Msp430TimerC.TimerB;
    Msp430TimerControl[6] = Msp430TimerC.ControlB6;
    Msp430Compare[6] = Msp430TimerC.CompareB6;
#endif

#else
    Msp430Timer[0] = Msp430TimerC.TimerA;
    Msp430TimerControl[0] = Msp430TimerC.ControlA0;
    Msp430Compare[0] = Msp430TimerC.CompareA0;

    Msp430Timer[1] = Msp430TimerC.TimerA;
    Msp430TimerControl[1] = Msp430TimerC.ControlA1;
    Msp430Compare[1] = Msp430TimerC.CompareA1;

#if defined(__MSP430_HAS_TA3__)
    Msp430Timer[2] = Msp430TimerC.TimerA;
    Msp430TimerControl[2] = Msp430TimerC.ControlA2;
    Msp430Compare[2] = Msp430TimerC.CompareA2;
#endif
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
