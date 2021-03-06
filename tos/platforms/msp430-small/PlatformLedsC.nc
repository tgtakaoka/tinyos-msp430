/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G Takaoka
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

#include "hardware.h"
#include "PlatformLed.h"

configuration PlatformLedsC {
    provides {
        interface GeneralIO as Led0;
        interface GeneralIO as Led1;
        interface GeneralIO as Led2;
    }
    uses interface Init;
}
implementation {
    components HplMsp430GeneralIOC as PinsC;
#ifdef PORT_LED0
    components new Msp430GpioC() as Led0Port;
    components new InvertGeneralIOP() as Led0Inv;
    Led0 = Led0Inv;
    Led0Inv.Inverted -> Led0Port;
    Led0Port -> PinsC.PORT_LED0;
#else
#warning "This platform has no LED0"
    components new NoPinC() as DummyLed0;
    Led0 = DummyLed0;
#endif
#ifdef PORT_LED1
    components new Msp430GpioC() as Led1Port;
    components new InvertGeneralIOP() as Led1Inv;
    Led1 = Led1Inv;
    Led1Inv.Inverted -> Led1Port;
    Led1Port -> PinsC.PORT_LED1;
#else
#warning "This platform has no LED1"
    components new NoPinC() as DummyLed1;
    Led1 = DummyLed1;
#endif
#ifdef PORT_LED2
    components new Msp430GpioC() as Led2Port;
    components new InvertGeneralIOP() as Led2Inv;
    Led2 = Led2Inv;
    Led2Inv.Inverted -> Led2Port;
    Led2Port -> PinsC.PORT_LED2;
#else
#warning "This platform has no LED2"
    components new NoPinC() as DummyLed2;
    Led2 = DummyLed2;
#endif
    components PlatformP;

    Init = PlatformP.LedsInit;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
