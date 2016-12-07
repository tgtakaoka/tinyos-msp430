/* -*- mode: nesc; mode: flyspell-prog; -*- */

#if defined(USE_USCI_UART)
#include "msp430usci.h"
#elif defined(USE_USART_UART)
#include "msp430usart.h"
#endif

configuration PlatformUartC {
    provides interface StdControl as UartControl;
    provides interface UartStream;
    provides interface UartByte;
}
implementation {
#if defined(USE_USCI_UART)
    components new USE_USCI_UART() as UartC;
    components UsciConf as UartConf;
#elif defined(USE_USART_UART)
    components new USE_USART_UART() as UartC;
    components UsartConf as UartConf;
#endif
    UartStream = UartC;
    UartByte = UartC;

    UartConf.UartControl = UartControl;
    UartConf.Msp430UartConfigure <- UartC;
    UartConf.UartResource -> UartC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
