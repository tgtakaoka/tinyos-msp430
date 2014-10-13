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
#if 0 < PLATFORM_LED_COUNT
        interface GeneralIO as Led0;
#if 1 < PLATFORM_LED_COUNT
        interface GeneralIO as Led1;
#if 2 < PLATFORM_LED_COUNT
        interface GeneralIO as Led2;
#endif
#endif
#endif
    }
    uses interface Init;
}
implementation {
    components HplMsp430GeneralIOC as GpioC;
#if 0 < PLATFORM_LED_COUNT
    components new Msp430GpioC() as Led0Port;
    components new InvertGeneralIOC() as Led0Inv;
    Led0 = Led0Inv;
    Led0Inv.Inverted -> Led0Port;
    Led0Port -> GpioC.PORT_LED0;
#if 1 < PLATFORM_LED_COUNT
    components new Msp430GpioC() as Led1Port;
    components new InvertGeneralIOC() as Led1Inv;
    Led1 = Led1Inv;
    Led1Inv.Inverted -> Led1Port;
    Led1Port -> GpioC.PORT_LED1;
#if 2 < PLATFORM_LED_COUNT
    components new Msp430GpioC() as Led2Port;
    components new InvertGeneralIOC() as Led2Inv;
    Led2 = Led2Inv;
    Led2Inv.Inverted -> Led2Port;
    Led2Port -> GpioC.PORT_LED2;
#endif
#endif
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
