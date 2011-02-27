/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usci.h"

configuration PlatformI2CC {
    provides interface StdControl as I2CControl;
    provides interface I2CPacket<TI2CBasicAddr>;
}
implementation {
    components new Msp430I2C0C() as I2CC;
    I2CPacket = I2CC;

    components UsciConf;
    I2CControl = UsciConf.I2CControl;
    UsciConf.Msp430I2CConfigure <- I2CC;
    UsciConf.I2CResource -> I2CC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
