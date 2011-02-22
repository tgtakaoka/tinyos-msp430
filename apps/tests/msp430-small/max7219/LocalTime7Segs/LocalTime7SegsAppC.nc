/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G. Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

configuration LocalTime7SegsAppC
{
}
implementation
{
    components MainC;
    components LocalTime7SegsC as App;
    components LedC;
    components new TimerMilliC() as Timer;
    components LocalTimeMilliC as LocalTime;

    components HplMsp430GeneralIOC as GeneralIOC;
    components new Msp430GpioC() as DIN;
    components new Msp430GpioC() as CS;
    components new Msp430GpioC() as CLK;
    components new Max7219P("Max7219");
    components new Led7SegsC("Max7219", 2, uint16_t) as Sec;
    components new Led7SegsC("Max7219", 2, uint16_t) as Min;
    components new Led7SegsC("Max7219", 2, uint16_t) as Hour;

    Max7219P.Boot -> MainC.Boot;
    Max7219P.DIN -> DIN;
    DIN -> GeneralIOC.Port15;
    Max7219P.CS -> CS;
    CS -> GeneralIOC.Port14;
    Max7219P.CLK -> CLK;
    CLK -> GeneralIOC.Port13;

    Sec.Led7Seg -> Max7219P.Led7Seg;
    Min.Led7Seg -> Max7219P.Led7Seg;
    Hour.Led7Seg -> Max7219P.Led7Seg;

    App.Boot -> MainC.Boot;
    App.Timer -> Timer;
    App.LocalTime -> LocalTime;
    App.Sec -> Sec.Led7Segs;
    App.Min -> Min.Led7Segs;
    App.Hour -> Hour.Led7Segs;
    App.Led -> LedC.Led0;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
