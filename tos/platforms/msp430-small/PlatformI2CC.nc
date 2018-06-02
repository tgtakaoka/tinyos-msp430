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

generic configuration PlatformI2CC() {
    provides {
        interface Resource;
        interface ResourceRequested;
        interface I2CPacket<TI2CBasicAddr>;
    }
    uses {
#if defined(PLATFORM_I2C_MASTER_BITBANG)
        interface BitBangI2CMasterConfigure as I2CConfigure;
#else
        interface Msp430I2CConfigure as I2CConfigure;
#endif
    }
}
implementation {
#if defined(PLATFORM_I2C_MASTER_BITBANG)
    components new BitBangI2CMasterC() as I2CMasterC;
#elif defined(PLATFORM_I2C_MASTER_USI)
    components new Msp430I2CC() as I2CMasterC;
#elif defined(PLATFORM_I2C_MASTER_USCI_B0)
    components new Msp430I2CB0C() as I2CMasterC;
#elif defined(PLATFORM_I2C_MASTER_USCI_B1)
    components new Msp430I2CB1C() as I2CMasterC;
#elif defined(PLATFORM_I2C_MASTER_USART0)
    components new Msp430I2CC() as I2CMasterC;
#endif

    Resource = I2CMasterC;
    ResourceRequested = I2CMasterC;
    I2CPacket = I2CMasterC;
    I2CConfigure = I2CMasterC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
