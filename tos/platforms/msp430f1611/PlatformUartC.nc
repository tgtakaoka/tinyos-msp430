/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usart.h"

configuration PlatformUartC {
    provides interface StdControl as UartControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
#if 1
    components new Msp430Uart0C() as UartC;
#else
    // USART1/UART Receiver will not work [Issue 3]
    components new Msp430Uart1C() as UartC;
#endif
    UartStream = UartC;
    UartByte = UartC;

    components UsartConf;
    UsartConf.UartControl = UartControl;
    UsartConf.Msp430UartConfigure <- UartC;
    UsartConf.UartResource -> UartC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
