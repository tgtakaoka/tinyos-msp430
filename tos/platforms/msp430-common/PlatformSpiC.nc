/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_SPI_MASTER
#include "SpiMaster.h"

configuration PlatformSpiC {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
    }
}
implementation {
    components GpioConf as GpioC;
    components new SpiMasterC(SPI_MASTER_MODE0, SPI_MASTER_MSB);

    SpiByte = SpiMasterC;
    SpiControl = SpiMasterC;

    SpiMasterC.SIMO -> GpioC.SIMO;
    SpiMasterC.SOMI -> GpioC.SOMI;
    SpiMasterC.CLK -> GpioC.CLK;
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
