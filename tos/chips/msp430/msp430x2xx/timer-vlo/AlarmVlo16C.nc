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

generic configuration AlarmVlo16C()
{
    provides interface Init;
    provides interface Alarm<TVlo,uint16_t>;
}
implementation
{
    components new Msp430TimerVloC() as Msp430Timer;
    components new Msp430AlarmC(TVlo) as Msp430Alarm;

    Init = Msp430Alarm;
    Alarm = Msp430Alarm;

    Msp430Alarm.Msp430Timer -> Msp430Timer;
    Msp430Alarm.Msp430TimerControl -> Msp430Timer;
    Msp430Alarm.Msp430Compare -> Msp430Timer;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
