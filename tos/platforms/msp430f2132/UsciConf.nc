/* -*- mode: nesc; mode: flyspell-prog; -*- */

module UsciConf {
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

    const msp430_spi_union_config_t spi_config = {
        {
        ubr     : 2,            /* SMCLK/2   */
        ucmode  : 0,            /* 3 pin, no STE */
        ucmst   : 1,            /* master */
        uc7bit  : 0,            /* 8 bit */
        ucmsb   : 1,            /* msb first, compatible with msp430 usart */
        ucckpl  : 0,            /* inactive state low */
        ucckph  : 1,            /* data captured on rising, changed falling */
        ucssel  : 2,            /* SMCLK */
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

    static const msp430_i2c_union_config_t i2c_config = {
        {
        ubr     : 2,			/* SMCLK/2 */
        ucmode  : 3,			/* i2c mode */
        ucmst   : 1,			/* master */
        ucmm    : 0,			/* single master */
        ucsla10 : 0,			/* 7 bit slave address */
        uca10   : 0,			/* 7 bit own address */
        uctr    : 1,			/* tx mode to start */
        ucssel  : 2,			/* SMCLK */
        i2coa   : 1,			/* our address is 1 */
        ucgcen  : 0,			/* respond to general call */
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
