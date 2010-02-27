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

configuration HilTimerMilliC
{
    provides interface Init;
    provides interface Timer<TMilli> as TimerMilli[uint8_t num];
    provides interface LocalTime<TMilli>;
}
implementation
{
    components new AlarmMilliVlo32C() as AlarmMilliC;
    components new AlarmToTimerC(TMilli);
    components new VirtualizeTimerC(TMilli,uniqueCount(UQ_TIMER_MILLI));
    components new CounterToLocalTimeC(TMilli);
    components CounterMilliVlo32C as CounterMilliC;

    Init = AlarmMilliC;
    TimerMilli = VirtualizeTimerC;
    LocalTime = CounterToLocalTimeC;

    VirtualizeTimerC.TimerFrom -> AlarmToTimerC;
    AlarmToTimerC.Alarm -> AlarmMilliC;
    CounterToLocalTimeC.Counter -> CounterMilliC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
