/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#if defined(USE_BIT_BANG_SPI_MASTER)
#include "BitBangSpiMaster.h"
#elif defined(USE_USI_SPI_MASTER)
#include "msp430usi.h"
#elif defined(USE_USCI_SPI_MASTER)
#include "msp430usci.h"
#elif defined(USE_USART_SPI_MASTER)
#include "msp430usart.h"
#endif

configuration PlatformSpiC {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
    }
}
implementation {
#if defined(USE_BIT_BANG_SPI_MASTER)
    components new BitBangSpiMasterP(SPI_MASTER_MODE0, SPI_MASTER_MSB)
        as SpiMaster;
    components GpioConf as SpiC;
    SpiMaster.SIMO -> SpiC.SIMO;
    SpiMaster.SOMI -> SpiC.SOMI;
    SpiMaster.CLK -> SpiC.CLK;
    SpiControl = SpiMaster;
#elif defined(USE_USI_SPI_MASTER)
    components new USE_USI_SPI_MASTER() as SpiMaster;
    components UsiConf as SpiC;
    SpiControl = SpiC.SpiControl;
    SpiC.Msp430SpiConfigure <- SpiMaster;
    SpiC.SpiResource -> SpiMaster;
#elif defined(USE_USCI_SPI_MASTER)
    components new USE_USCI_SPI_MASTER() as SpiMaster;
    components UsciConf as SpiC;
    SpiControl = SpiC.SpiControl;
    SpiC.Msp430SpiConfigure <- SpiMaster;
    SpiC.SpiResource -> SpiMaster;
#elif defined(USE_USART_SPI_MASTER)
    components new USE_USART_SPI_MASTER() as SpiMaster;
    components UsartConf as SpiC;
    SpiControl = SpiC.SpiControl;
    SpiC.Msp430SpiConfigure <- SpiMaster;
    SpiC.SpiResource -> SpiMaster;
#endif
    SpiByte = SpiMaster;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
