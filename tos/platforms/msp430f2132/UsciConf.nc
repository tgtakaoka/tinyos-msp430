/* -*- mode: nesc; mode: flyspell-prog; -*- */

module UsciConf {
    provides interface StdControl as UartControl;
    provides interface Msp430UartConfigure;
    uses interface Resource as UartResource;
}
implementation {
    const msp430_uart_union_config_t uart_config = {
        {
        ucssel : 0x01,             // baud rate clock source ACLK=32kHz
        ubr    : UBR_32KHZ_9600,   // baud rate
        umctl  : UMCTL_32KHZ_9600, // baud rate modulation
        uc7bit : 0,                // 8-bit character
        ucspb  : 0,                // 1 stop bit
        ucpen  : 0,                // no parity
        ucpar  : 1,                // (even parity)
        ucrxeie: 1,                // erroneous character receive and URXIFG set
        utxe   : 1,                // enable tx module
        urxe   : 1,                // enable rx module
        },
    };

    command error_t UartControl.start() {
        return call UartResource.immediateRequest();
    }

    command error_t UartControl.stop() {
        call UartResource.release();
        return SUCCESS;
    }

    event void UartResource.granted() {}

    async command const msp430_uart_union_config_t* Msp430UartConfigure.getConfig() {
        return &uart_config;
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
