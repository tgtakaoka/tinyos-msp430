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

module PlatformSerialP {
    provides interface StdControl as SerialControl;
    uses interface Resource as SerialResource;
}
implementation {
    // To enable USCI UART pins, P1SEL2 is necessary to set 1 on MSP430G2553.
    // P1.1=UCA0RXD
    // P1.2=UCA0TXD
#if defined(PLATFORM_UART_USCI_A0)
    enum {
        USCI_PINS = (1 << 1) | (1 << 2),
    };
#endif

    command error_t SerialControl.start() {
#if defined(PLATFORM_UART_USCI_A0)
        P1SEL2 |= USCI_PINS;
#endif
        return call SerialResource.immediateRequest();
    }

    command error_t SerialControl.stop() {
        call SerialResource.release();
#if defined(PLATFORM_UART_USCI_A0)
        P1SEL2 &= ~USCI_PINS;
#endif
        return SUCCESS;
    }

    event void SerialResource.granted() {
    }
}
