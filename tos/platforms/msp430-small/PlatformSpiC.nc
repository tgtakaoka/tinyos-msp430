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
#else
#error "This platform has no SPI Master defined"
#endif

configuration PlatformSpiC {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
#if defined(USE_BIT_BANG_SPI_MASTER)
        interface GeneralIO as SIMO;
        interface GeneralIO as SOMI;
        interface GeneralIO as CLK;
#endif
    }
}
implementation {
#if defined(USE_BIT_BANG_SPI_MASTER)
    components new BitBangSpiMasterC() as SpiMaster;
    components UsciConf as SpiC;
    SpiControl = SpiC.SpiControl;
    SpiC.SpiResource -> SpiMaster;
    components GpioConf;
    SIMO = GpioConf.SIMO;
    SOMI = GpioConf.SOMI;
    CLK = GpioConf.CLK;
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
