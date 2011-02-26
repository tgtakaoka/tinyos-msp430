/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usart.h"

configuration PlatformSpiC {
    provides interface StdControl as SpiControl;
    provides interface SpiByte;
    provides interface SpiPacket;
}
implementation {
    components new Msp430Spi0C() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsartConf;
    SpiControl = UsartConf.SpiControl;
    UsartConf.Msp430SpiConfigure <- SpiC;
    UsartConf.SpiResource -> SpiC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */