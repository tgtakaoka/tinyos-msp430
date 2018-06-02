/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2018, Tadashi G. Takaoka
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

configuration PlatformPinsC {
    provides {
        interface GeneralIO as SpiCS0;
#if defined(PLATFORM_SPI_MASTER_BITBANG)
        interface GeneralIO as SpiSIMO;
        interface GeneralIO as SpiSOMI;
        interface GeneralIO as SpiCLK;
#endif
#if defined(PLATFORM_I2C_MASTER_BITBANG)
        interface GeneralIO as I2CSCL;
        interface GeneralIO as I2CSDA;
#endif
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;

    // SPI bus
    components new Msp430GpioC() as CS0;
    SpiCS0 = CS0;
    CS0 -> IOC.Port15;
#if defined(PLATFORM_SPI_MASTER_BITBANG)
    components new Msp430GpioC() as SIMO;
    components new Msp430GpioC() as SOMI;
    components new Msp430GpioC() as CLK;
    SpiSIMO = SIMO;
    SpiSOMI = SOMI;
    SpiCLK = CLK;
    SIMO -> IOC.Port12;
    SOMI -> IOC.Port11;
    CLK -> IOC.Port14;
#endif

#if defined(PLATFORM_I2C_MASTER_BITBANG)
    // I2C bus
    components new Msp430GpioC() as SCL;
    components new Msp430GpioC() as SDA;
    I2CSCL = SCL;
    I2CSDA = SDA;
    SCL -> IOC.Port16;
    SDA -> IOC.Port17;
#endif
}
