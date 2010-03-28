/* -*- mode: nesc; mode: flyspell-prog; -*- */
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

module Clock7SegsC
{
    uses interface Led7Segs<uint16_t> as Hour;
    uses interface Led7Segs<uint16_t> as Min;
    uses interface Led7Segs<uint16_t> as Sec;
    uses interface Led7Segs<uint16_t> as CentiSec;
    uses interface Led;
    uses interface Timer16<TMilli>;
    uses interface Boot;
}
implementation
{
    uint16_t centiSec = 0;
    uint16_t sec = 0;
    uint16_t min = 0;
    uint16_t hour = 0;

    void update() {
        call Hour.dec0(hour);
        call Min.dec0(min);
        call Sec.dec0(sec);
        call CentiSec.dec0(centiSec);
        atomic {
            if (centiSec == 0) {
                call Led.on();
            } else if (centiSec == 10) {
                call Led.off();
            }
        }
    }

    event void Boot.booted() {
        update();
        call Timer16.startPeriodic(10);
    }

    event void Timer16.fired() {
        call Led.toggle();
        if (++centiSec == 100) {
            centiSec = 0;
            if (++sec == 60) {
                sec = 0;
                if (++min == 60) {
                    min = 0;
                    if (++hour == 24)
                        hour = 0;
                }
            }
        }
        update();
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
