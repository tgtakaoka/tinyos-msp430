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

#include "BitBangSpiMaster.h"

/** A software SPI master implementation using GPIO.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic configuration BitBangSpiMasterC() {
    provides {
        interface Resource;
        interface ResourceRequested;
        interface SpiByte;
        interface SpiPacket;
    }
    uses interface BitBangSpiMasterConfigure as SpiMasterConfigure;
}
implementation {

    enum {
        CLIENT_ID = unique(BIT_BANG_SPI_MASTER_RESOURCE),
    };

    components new SimpleFcfsArbiterC(BIT_BANG_SPI_MASTER_RESOURCE) as ArbiterC;
    components new BitBangSpiMasterP() as SpiP;
    components PlatformSpiC as SpiPins;

    Resource = ArbiterC.Resource[CLIENT_ID];
    ResourceRequested = ArbiterC.ResourceRequested[CLIENT_ID];

    SpiP.SpiByte = SpiByte;
    SpiP.SpiPacket[CLIENT_ID] = SpiPacket;
    SpiP.SIMO -> SpiPins.SIMO;
    SpiP.SOMI -> SpiPins.SOMI;
    SpiP.CLK -> SpiPins.CLK;

    SpiP.ResourceConfigure[CLIENT_ID] <- ArbiterC.ResourceConfigure[CLIENT_ID];
    SpiP.Configure[CLIENT_ID] = SpiMasterConfigure;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
