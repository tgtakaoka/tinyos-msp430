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

configuration PlatformLedsC
{
    provides interface GeneralIO as Led0;
    provides interface GeneralIO as Led1;
    provides interface GeneralIO as Led2;
    uses interface Init;
}
implementation
{
    components HplMsp430GeneralIOC as GeneralIOC;
    components new Msp430GpioC() as Led0Impl;
    components new Msp430GpioC() as Led1Impl;
    components new Msp430GpioC() as Led2Impl;
    components new InvertGeneralIO() as Led0Inv;
    components new InvertGeneralIO() as Led1Inv;
    components new InvertGeneralIO() as Led2Inv;
    components PlatformP;

    Init = PlatformP.LedsInit;

    Led0 = Led0Inv;
    Led0Inv.Impl -> Led0Impl;
    Led0Impl -> GeneralIOC.Port10;

    Led1 = Led1Inv;
    Led1Inv.Impl -> Led1Impl;
    Led1Impl -> GeneralIOC.Port11;

    Led2 = Led2Inv;
    Led2Inv.Impl -> Led2Impl;
    Led2Impl -> GeneralIOC.Port10;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
