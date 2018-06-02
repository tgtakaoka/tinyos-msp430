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
    provides {
        interface StdControl;
#if defined(PLATFORM_UART_BITBANG)
        interface BitBangUartConfigure as Configure;
#else
        interface Msp430UartConfigure as Configure;
#endif
    }
    uses interface Resource;
}
implementation {
#if defined(PLATFORM_UART_BITBANG)
#elif defined(PLATFORM_UART_USCI_A0) || defined(PLATFORM_UART_USCI_A1)
    const msp430_uart_union_config_t dco16m_uart115k_config = { {
        ubr    : UBR_16MIHZ_115200,
        umctl  : UMCTL_16MIHZ_115200,
        ucssel : 2,
    }};
#elif defined(PLATFORM_UART_USART0) || defined(PLATFORM_UART_USART1)
    const msp430_uart_union_config_t dco4m_uart115k_config = { {
        ubr    : UBR_4MIHZ_115200,
        umctl  : UMCTL_4MIHZ_115200,
        ssel : 2,
    }};
#endif
    command error_t StdControl.start() {
        return call Resource.immediateRequest();
    }

    command error_t StdControl.stop() {
        call Resource.release();
        return SUCCESS;
    }

    event void Resource.granted() {
    }

#if defined(PLATFORM_UART_BITBANG)
    async command bit_bang_uart_config_t Configure.getConfig() {
    }
#elif defined(PLATFORM_UART_USCI_A0) || defined(PLATFORM_UART_USCI_A1)
    async command const msp430_uart_union_config_t* Configure.getConfig() {
        return &dco16m_uart115k_config;
    }
#elif defined(PLATFORM_UART_USART0) || defined(PLATFORM_UART_USART1)
    async command const msp430_uart_union_config_t* Configure.getConfig() {
        return &dco4m_uart115k_config;
    }
#endif
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
