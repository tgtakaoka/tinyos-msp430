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

#include "Timer.h"
#include "Timer-vlo.h"

configuration HilTimerMilli16C {
    provides interface Init;
    provides interface Timer16<TMilli> as TimerMilli16[uint8_t num];
}
implementation
{
    components new AlarmMilliVlo16C() as AlarmMilliC;
    components new AlarmToTimer16C(TMilli);
    components new VirtualizeTimer16C(TMilli,uniqueCount(UQ_TIMER_MILLI16));

    Init = AlarmMilliC;
    TimerMilli16 = VirtualizeTimer16C;

    VirtualizeTimer16C.TimerFrom -> AlarmToTimer16C;
    AlarmToTimer16C.Alarm -> AlarmMilliC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
