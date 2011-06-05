/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usci.h"

configuration PlatformUartC {
    provides interface StdControl as UartControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
    components new Msp430Uart0C() as UartC;
    UartStream = UartC;
    UartByte = UartC;

    components UsciConf;
    UsciConf.UartControl = UartControl;
    UsciConf.Msp430UartConfigure <- UartC;
    UsciConf.UartResource -> UartC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
