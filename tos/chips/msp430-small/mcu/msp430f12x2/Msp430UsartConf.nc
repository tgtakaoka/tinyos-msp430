/* -*- mode: nesc; mode: flyspell-prog; -*- */

/* USART pin configuration of MSP430F12x2 */
configuration Msp430UsartConf {
    provides {
        interface HplMsp430GeneralIO as STE0;
        interface HplMsp430GeneralIO as SIMO0;
        interface HplMsp430GeneralIO as SOMI0;
        interface HplMsp430GeneralIO as UCLK0;
        interface HplMsp430GeneralIO as UTXD0;
        interface HplMsp430GeneralIO as URXD0;
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;

    STE0 = IOC.Port30;
    SIMO0 = IOC.Port31;
    SOMI0 = IOC.Port32;
    UCLK0 = IOC.Port33;
    UTXD0 = IOC.Port34;
    URXD0 = IOC.Port35;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
