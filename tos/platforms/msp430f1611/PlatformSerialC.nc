/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usart.h"

configuration PlatformSerialC {
    provides interface StdControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
    components new Msp430Uart0C() as UartC;
    UartStream = UartC;
    UartByte = UartC;

    components Msp430SerialP;
    StdControl = Msp430SerialP;
    Msp430SerialP.Msp430UartConfigure <- UartC.Msp430UartConfigure;
    Msp430SerialP.Resource -> UartC.Resource;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
