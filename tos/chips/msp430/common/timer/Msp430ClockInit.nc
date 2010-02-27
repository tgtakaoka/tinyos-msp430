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

interface Msp430ClockInit
{
#if !defined(__MSP430_HAS_BC2__)
    event void setupDcoCalibrate();
#endif
    event void initClocks();
    event void initTimerA();
#if defined(__MSP430_HAS_T1A2__)
    event void initTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    event void initTimerB();
#endif

#if !defined(__MSP430_HAS_BC2__)
    command void defaultSetupDcoCalibrate();
#endif
    command void defaultInitClocks();
    command void defaultInitTimerA();
#if defined(__MSP430_HAS_T1A2__)
    command void defaultInitTimer1A();
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
    command void defaultInitTimerB();
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
