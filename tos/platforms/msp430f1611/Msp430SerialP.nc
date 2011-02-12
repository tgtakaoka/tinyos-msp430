/* -*- mode: nesc; mode: flyspell-prog; -*- */

module Msp430SerialP {
    provides interface StdControl;
    provides interface Msp430UartConfigure;
    uses interface Resource;
}
implementation {
    const msp430_uart_union_config_t msp430_uart_config = {
        {
        ssel   : 0x01,             // baud rate clock source ACLK=32kHz
        ubr    : UBR_32KHZ_9600,   // baud rate
        umctl  : UMCTL_32KHZ_9600, // baud rate modulation
        clen   : 1,                // 8-bit character
        spb    : 0,                // 1 stop bit
        pena   : 0,                // no parity
        pev    : 1,                // (even parity)
        listen : 0,                // listen disabled
        mm     : 0,                // idle-line protocol for multiprocessor
        ckpl   : 0,                // normal clock polarity
        urxse  : 0,                // receive start-edge detection disabled
        urxeie : 1,                // erroneous character receive and URXIFG set
        urxwie : 0,                // all character set wake-up interrupt
        utxe   : 1,                // enable tx module
        urxe   : 1,                // enable rx module
        },
    };

    command error_t StdControl.start() {
        return call Resource.immediateRequest();
    }

    command error_t StdControl.stop() {
        call Resource.release();
        return SUCCESS;
    }

    event void Resource.granted() {}

    async command const msp430_uart_union_config_t* Msp430UartConfigure.getConfig() {
        return &msp430_uart_config;
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
