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

module PlatformI2CP {
    provides interface StdControl as I2CControl;
    uses interface Resource as I2CResource;
}
implementation {
    // To enable USCI I2C pins, P1SEL2 is necessary to set 1 on MSP430G2553.
    // P1.6=UCB0SCL
    // P1.7=UCB0SDA
#if defined(PLATFORM_I2C_MASTER_USCI_B0)
    enum {
        USCI_PINS = (1 << 6) | (1 << 7),
    };
#endif

    command error_t I2CControl.start() {
#if defined(PLATFORM_I2C_MASTER_USCI_B0)
        P1SEL2 |= USCI_PINS;
#endif
        return call I2CResource.immediateRequest();
    }

    command error_t I2CControl.stop() {
        call I2CResource.release();
#if defined(PLATFORM_I2C_MASTER_USCI_B0)
        P1SEL2 &= ~USCI_PINS;
#endif
        return SUCCESS;
    }

    event void I2CResource.granted() {
    }
}
