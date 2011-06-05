/* -*- mode: nesc; mode: flyspell-prog; -*- */

/* USCI pin configuration of MSP430F261x */
configuration HplMsp430UsciC {
    provides {
        interface HplMsp430GeneralIO as UCA0STE;
        interface HplMsp430GeneralIO as UCA0SIMO;
        interface HplMsp430GeneralIO as UCA0SOMI;
        interface HplMsp430GeneralIO as UCA0CLK;
        interface HplMsp430GeneralIO as UCA0TXD;
        interface HplMsp430GeneralIO as UCA0RXD;

        interface HplMsp430GeneralIO as UCA1STE;
        interface HplMsp430GeneralIO as UCA1SIMO;
        interface HplMsp430GeneralIO as UCA1SOMI;
        interface HplMsp430GeneralIO as UCA1CLK;
        interface HplMsp430GeneralIO as UCA1TXD;
        interface HplMsp430GeneralIO as UCA1RXD;

        interface HplMsp430GeneralIO as UCB0STE;
        interface HplMsp430GeneralIO as UCB0SIMO;
        interface HplMsp430GeneralIO as UCB0SOMI;
        interface HplMsp430GeneralIO as UCB0CLK;
        interface HplMsp430GeneralIO as UCB0SDA;
        interface HplMsp430GeneralIO as UCB0SCL;

        interface HplMsp430GeneralIO as UCB1STE;
        interface HplMsp430GeneralIO as UCB1SIMO;
        interface HplMsp430GeneralIO as UCB1SOMI;
        interface HplMsp430GeneralIO as UCB1CLK;
        interface HplMsp430GeneralIO as UCB1SDA;
        interface HplMsp430GeneralIO as UCB1SCL;
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

    UCA1STE = IOC.Port53;
    UCA1SIMO = IOC.Port36;
    UCA1SOMI = IOC.Port37;
    UCA1CLK = IOC.Port50;
    UCA1TXD = IOC.Port36;
    UCA1RXD = IOC.Port37;

    UCB0STE = IOC.Port30;
    UCB0SIMO = IOC.Port31;
    UCB0SOMI = IOC.Port32;
    UCB0CLK = IOC.Port33;
    UCB0SDA = IOC.Port31;
    UCB0SCL = IOC.Port32;

    UCB1STE = IOC.Port50;
    UCB1SIMO = IOC.Port51;
    UCB1SOMI = IOC.Port52;
    UCB1CLK = IOC.Port53;
    UCB1SDA = IOC.Port51;
    UCB1SCL = IOC.Port52;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
