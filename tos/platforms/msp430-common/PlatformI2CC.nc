/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_I2C_MASTER
#include "I2C.h"
#include "I2CMaster.h"

configuration PlatformI2CC {
    provides {
        interface StdControl as I2CControl;
        interface I2CPacket<TI2CBasicAddr>;
    }
}
implementation {
    components GpioConf as GpioC;
    components new I2CMasterC(TI2CBasicAddr, I2C_MASTER_BASIC_ADDR);

    I2CPacket = I2CMasterC;
    I2CControl = I2CMasterC;

    I2CMasterC.SCL -> GpioC.SCL;
    I2CMasterC.SDA -> GpioC.SDA;
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
