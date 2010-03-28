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

configuration Max7219C
{
    provides interface Led7Seg[int digits];
    uses interface Boot;
}
implementation
{
    components Max7219P;
    components HplMsp430GeneralIOC as GeneralIOC;
    components new Msp430GpioC() as Data;
    components new Msp430GpioC() as Load;
    components new Msp430GpioC() as Clock;

    Led7Seg = Max7219P.Led7Seg;

    Boot = Max7219P;

    Max7219P.Data -> Data;
    Data -> GeneralIOC.Port15;

    Max7219P.Load -> Load;
    Load -> GeneralIOC.Port14;

    Max7219P.Clock -> Clock;
    Clock -> GeneralIOC.Port13;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
