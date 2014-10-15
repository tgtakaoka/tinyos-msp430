/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_BIT_BANG_SPI_MASTER
#include "BitBangSpiMaster.h"

configuration PlatformSpiC {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
    }
}
implementation {
    components GpioConf as GpioC;
    components new BitBangSpiMasterC(SPI_MASTER_MODE0, SPI_MASTER_MSB);

    SpiByte = BitBangSpiMasterC;
    SpiControl = BitBangSpiMasterC;

    BitBangSpiMasterC.SIMO -> GpioC.SIMO;
    BitBangSpiMasterC.SOMI -> GpioC.SOMI;
    BitBangSpiMasterC.CLK -> GpioC.CLK;
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
