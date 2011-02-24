/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usart.h"

configuration PlatformUartC {
    provides interface StdControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
    components new Msp430Uart0C() as UartC;
    UartStream = UartC;
    UartByte = UartC;

    components UsartConf;
    UsartConf.UartControl = StdControl;
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
