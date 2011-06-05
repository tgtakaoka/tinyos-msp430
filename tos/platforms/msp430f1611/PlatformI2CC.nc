/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_I2C_MASTER
#include_next "PlatformI2CC.nc"
#else

#include "msp430usart.h"

configuration PlatformI2CC {
    provides interface StdControl as I2CControl;
    provides interface I2CPacket<TI2CBasicAddr>;
}
implementation {
    components new Msp430I2CC() as I2CC;
    I2CPacket = I2CC;

    components UsartConf;
    I2CControl = UsartConf.I2CControl;
    UsartConf.Msp430I2CConfigure <- I2CC;
    UsartConf.I2CResource -> I2CC;
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