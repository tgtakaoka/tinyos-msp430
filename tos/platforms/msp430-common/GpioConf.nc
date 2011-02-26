/* -*- mode: nesc; mode: flyspell-prog; -*- */

configuration GpioConf {
    provides {
        interface GeneralIO as STE;
        interface GeneralIO as SIMO;
        interface GeneralIO as SOMI;
        interface GeneralIO as CLK;
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;
    components new Msp430GpioC() as STE0;
    components new Msp430GpioC() as SIMO0;
    components new Msp430GpioC() as SOMI0;
    components new Msp430GpioC() as CLK0;

    STE0  -> IOC.Port14;
    CLK0  -> IOC.Port15;
    SIMO0 -> IOC.Port16;
    SOMI0 -> IOC.Port17;

    STE  = STE0;
    CLK  = CLK0;
    SIMO = SIMO0;
    SOMI = SOMI0;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
