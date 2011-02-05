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
