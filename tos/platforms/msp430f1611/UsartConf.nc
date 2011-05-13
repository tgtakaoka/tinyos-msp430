/* -*- mode: nesc; mode: flyspell-prog; -*- */

module UsartConf {
    provides interface StdControl as UartControl;
    provides interface Msp430UartConfigure;
    uses interface Resource as UartResource;

    provides interface StdControl as SpiControl;
    provides interface Msp430SpiConfigure;
    uses interface Resource as SpiResource;

    provides interface StdControl as I2CControl;
    provides interface Msp430I2CConfigure;
    uses interface Resource as I2CResource;
}
implementation {
    const msp430_uart_union_config_t uart_config = {
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

    const msp430_spi_union_config_t spi_config = {
        {
        ubr    : 2,             /* SMCLK/2 */
        stc    : 1,             /* 3 pin, no STE */
        mm     : 1,             /* master */
        clen   : 1,             /* 8 bit */
        ckpl   : 0,             /* inactive state low */
        ckph   : 1,             /* data captured on rising, changed falling */
        ssel   : 2,             /* SMCLK */
        },
    };

    command error_t SpiControl.start() {
        return call SpiResource.immediateRequest();
    }

    command error_t SpiControl.stop() {
        call SpiResource.release();
        return SUCCESS;
    }

    event void SpiResource.granted() {}

    async command const msp430_spi_union_config_t* Msp430SpiConfigure.getConfig() {
        return &spi_config;
    }

    const msp430_i2c_union_config_t i2c_config = { 
        {
        rxdmaen : 0, 
        txdmaen : 0, 
        xa : 0, 
        listen : 0, 
        mst : 1,
        i2cword : 0, 
        i2crm : 1, 
        i2cssel : 0x2, 
        i2cpsc : 0, 
        i2csclh : 0x3, 
        i2cscll : 0x3,
        i2coa : 0,
        } 
    };

    command error_t I2CControl.start() {
        return call I2CResource.immediateRequest();
    }

    command error_t I2CControl.stop() {
        call I2CResource.release();
        return SUCCESS;
    }

    event void I2CResource.granted() {}

    async command const msp430_i2c_union_config_t* Msp430I2CConfigure.getConfig() {
        return &i2c_config;
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
