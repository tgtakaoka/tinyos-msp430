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

configuration PlatformSerialC {
    provides {
        interface StdControl as SerialControl;
        interface UartStream;
        interface UartByte;
    }
    uses {
#if defined(PLATFORM_UART_BITBANG)
        interface BitBangUartConfigure as SerialConfigure;
#else
        interface Msp430UartConfigure as SerialConfigure;
#endif
    }
}
implementation {
#if defined(PLATFORM_UART_BITBANG)
    components new BitBangUartC() as SerialC;
#elif defined(PLATFORM_UART_USCI_A0)
    components new Msp430UartA0C() as SerialC;
#elif defined(PLATFORM_UART_USCI_A1)
    components new Msp430UartA1C() as SerialC;
#elif defined(PLATFORM_UART_USART0)
    components new Msp430Uart0C() as SerialC;
#elif defined(PLATFORM_UART_USART1)
    components new Msp430Uart1C() as SerialC;
#endif
    components PlatformSerialP as SerialP;

    SerialControl = SerialP.SerialControl;
    UartStream = SerialC;
    UartByte = SerialC;
    SerialConfigure = SerialC;
    SerialP.SerialResource -> SerialC;
}
