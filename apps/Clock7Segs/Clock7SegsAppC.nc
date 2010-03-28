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

configuration Clock7SegsAppC
{
}
implementation
{
    components MainC;
    components Max7219C;
    components Clock7SegsC;
    components LedC;
    components new TimerMilli16C() as Timer16;
    components new Led7SegsC("Max7219", 2, uint16_t) as CentiSec;
    components new Led7SegsC("Max7219", 2, uint16_t) as Sec;
    components new Led7SegsC("Max7219", 2, uint16_t) as Min;
    components new Led7SegsC("Max7219", 2, uint16_t) as Hour;

    Max7219C -> MainC.Boot;

    CentiSec.Led7Seg -> Max7219C.Led7Seg;
    Sec.Led7Seg -> Max7219C.Led7Seg;
    Min.Led7Seg -> Max7219C.Led7Seg;
    Hour.Led7Seg -> Max7219C.Led7Seg;

    Clock7SegsC.Boot -> MainC.Boot;
    Clock7SegsC.Timer16 -> Timer16;
    Clock7SegsC.CentiSec -> CentiSec.Led7Segs;
    Clock7SegsC.Sec -> Sec.Led7Segs;
    Clock7SegsC.Min -> Min.Led7Segs;
    Clock7SegsC.Hour -> Hour.Led7Segs;
    Clock7SegsC.Led -> LedC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
