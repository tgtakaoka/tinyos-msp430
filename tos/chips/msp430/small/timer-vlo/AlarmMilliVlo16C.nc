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

generic configuration AlarmMilliVlo16C()
{
    provides interface Init;
    provides interface Alarm<TMilli,uint16_t>;
}
implementation
{
    components new AlarmVlo16C() as AlarmFrom;
    components CounterMilliVlo16C as Counter;
    components new ApproximateAlarmC(TMilli,uint16_t,TVlo,uint16_t,
                                     VLO_HZ/1000) as Transform;

    Init = AlarmFrom;
    Alarm = Transform;

    Transform.AlarmFrom -> AlarmFrom;
    Transform.Counter -> Counter;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
