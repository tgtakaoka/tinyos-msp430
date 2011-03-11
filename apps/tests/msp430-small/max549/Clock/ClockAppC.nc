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

configuration ClockAppC {
}
implementation {
    components MainC;
    components ClockC as App;
    components DisplayC;
    components LedC;
    components new Timer16MilliC() as Timer;

    components new HplMax549C();
    components PlatformSpiC as SpiC;
    components HplMsp430GeneralIOC as GpioC;
    components new Msp430GpioC() as Max549CS;
    components new Max549P();

    Max549CS -> GpioC.Port13;
    HplMax549C.Boot -> MainC.Boot;
    HplMax549C.CS -> Max549CS;
    HplMax549C.SpiByte -> SpiC;
    HplMax549C.SpiControl -> SpiC;

    Max549P.Hpl -> HplMax549C;

    App.Max549 -> Max549P;
    App.Boot -> MainC.Boot;
    App.Timer -> Timer;
    App.Sec -> DisplayC.Sec;
    App.Min -> DisplayC.Min;
    App.Hour -> DisplayC.Hour;
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
