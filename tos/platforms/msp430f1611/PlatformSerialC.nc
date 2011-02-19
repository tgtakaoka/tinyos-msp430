/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usart.h"

configuration PlatformSerialC {
    provides interface StdControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
#if 0
    components new Msp430Uart0C() as UartC;
#else
    // USART1/UART Receiver will not work [Issue 3]
    components new Msp430Uart1C() as UartC;
#endif
    UartStream = UartC;
    UartByte = UartC;

    components UsartConf;
    StdControl = UsartConf;
    UsartConf.Msp430UartConfigure <- UartC.Msp430UartConfigure;
    UsartConf.Resource -> UartC.Resource;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
