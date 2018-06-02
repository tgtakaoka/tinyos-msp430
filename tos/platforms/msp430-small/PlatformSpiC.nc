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

generic configuration PlatformSpiC() {
    provides {
        interface Resource;
        interface ResourceRequested;
        interface SpiByte;
        interface SpiPacket;
    }
    uses {
#if defined(PLATFORM_SPI_MASTER_BITBANG)
        interface BitBangSpiMasterConfigure as SpiConfigure;
#else
        interface Msp430SpiConfigure as SpiConfigure;
#endif
    }
}
implementation {
#if defined(PLATFORM_SPI_MASTER_BITBANG)
    components new BitBangSpiMasterC() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USI)
    components new Msp430SpiC() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USCI_A0)
    components new Msp430SpiA0C() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USCI_A1)
    components new Msp430SpiA1C() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USCI_B0)
    components new Msp430SpiB0C() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USCI_B1)
    components new Msp430SpiB1C() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USART0)
    components new Msp430Spi0C() as SpiMasterC;
#elif defined(PLATFORM_SPI_MASTER_USART1)
    components new Msp430Spi1C() as SpiMasterC;
#endif

    Resource = SpiMasterC;
    ResourceRequested = SpiMasterC;
    SpiByte = SpiMasterC;
    SpiPacket = SpiMasterC;
    SpiConfigure = SpiMasterC;
}
