/* -*- mode: nesc; mode: flyspell-prog; -*- */

/* USCI pin configuration of MSP430G2x53 */
configuration Msp430UsciConf {
    provides {
        interface HplMsp430GeneralIO as UCA0STE;
        interface HplMsp430GeneralIO as UCA0SIMO;
        interface HplMsp430GeneralIO as UCA0SOMI;
        interface HplMsp430GeneralIO as UCA0CLK;
        interface HplMsp430GeneralIO as UCA0TXD;
        interface HplMsp430GeneralIO as UCA0RXD;

        interface HplMsp430GeneralIO as UCB0STE;
        interface HplMsp430GeneralIO as UCB0SIMO;
        interface HplMsp430GeneralIO as UCB0SOMI;
        interface HplMsp430GeneralIO as UCB0CLK;
        interface HplMsp430GeneralIO as UCB0SDA;
        interface HplMsp430GeneralIO as UCB0SCL;
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;

    UCA0STE = IOC.Port15;
    UCA0SIMO = IOC.Port12;
    UCA0SOMI = IOC.Port11;
    UCA0CLK = IOC.Port14;
    UCA0TXD = IOC.Port12;
    UCA0RXD = IOC.Port11;

    UCB0STE = IOC.Port14;
    UCB0SIMO = IOC.Port17;
    UCB0SOMI = IOC.Port16;
    UCB0CLK = IOC.Port15;
    UCB0SDA = IOC.Port17;
    UCB0SCL = IOC.Port16;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
