/* -*- mode: nesc; mode: flyspell-prog; -*- */

/* USCI pin configuration of MSP430F21x2 */
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

    UCA0STE = IOC.Port33;
    UCA0SIMO = IOC.Port34;
    UCA0SOMI = IOC.Port35;
    UCA0CLK = IOC.Port30;
    UCA0TXD = IOC.Port34;
    UCA0RXD = IOC.Port35;

    UCB0STE = IOC.Port30;
    UCB0SIMO = IOC.Port31;
    UCB0SOMI = IOC.Port32;
    UCB0CLK = IOC.Port33;
    UCB0SDA = IOC.Port31;
    UCB0SCL = IOC.Port32;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
