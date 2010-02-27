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
#include "Timer16.h"

interface Timer16<precision_tag>
{
    command void startPeriodic(uint16_t dt);
    command void startOneShot(uint16_t dt);
    command void stop();
    event void fired();
    command bool isRunning();
    command bool isOneShot();
    command void startPeriodicAt(uint16_t t0, uint16_t dt);
    command void startOneShotAt(uint16_t t0, uint16_t dt);
    command uint16_t getNow();
    command uint16_t gett0();
    command uint16_t getdt();
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
