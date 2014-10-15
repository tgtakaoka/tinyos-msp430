/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_BIT_BANG_I2C_MASTER
#include "I2C.h"
#include "BitBangI2CMaster.h"

configuration PlatformI2CC {
    provides {
        interface StdControl as I2CControl;
        interface I2CPacket<TI2CBasicAddr>;
    }
}
implementation {
    components GpioConf as GpioC;
    components new BitBangI2CMasterC(TI2CBasicAddr, I2C_MASTER_BASIC_ADDR);

    I2CPacket = BitBangI2CMasterC;
    I2CControl = BitBangI2CMasterC;

    BitBangI2CMasterC.SCL -> GpioC.SCL;
    BitBangI2CMasterC.SDA -> GpioC.SDA;
}
#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
