/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#include "I2C.h"
#if defined(USE_BIT_BANG_I2C_MASTER)
#include "BitBangI2CMaster.h"
#elif defined(USE_USCI_I2C_MASTER)
#include "msp430usci.h"
#elif defined(USE_USART_I2C_MASTER)
#include "msp430usart.h"
#else
#error "This platform has no I2C Master defined"
#endif

configuration PlatformI2CC {
    provides {
        interface StdControl as I2CControl;
        interface I2CPacket<TI2CBasicAddr>;
    }
}
implementation {
#if defined(USE_BIT_BANG_I2C_MASTER)
    components new BitBangI2CMasterP(TI2CBasicAddr, I2C_MASTER_BASIC_ADDR)
        as I2CMaster;
    components GpioConf;
    I2CMaster.SCL -> GpioConf.SCL;
    I2CMaster.SDA -> GpioConf.SDA;
    I2CControl = I2CMaster;
#elif defined(USE_USCI_I2C_MASTER)
    components new USE_USCI_I2C_MASTER() as I2CMaster;
    components UsciConf;
    UsciConf.Msp430I2CConfigure <- I2CMaster;
    UsciConf.I2CResource -> I2CMaster;
    I2CControl = UsciConf.I2CControl;
#elif defined(USE_USART_I2C_MASTER)
    components new USE_USART_I2C_MASTER() as I2CMaster;
    components UsartConf;
    UsartConf.Msp430I2CConfigure <- I2CMaster;
    UsartConf.I2CResource -> I2CMaster;
    I2CControl = UsartConf.I2CControl;
#endif

    I2CPacket = I2CMaster;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
