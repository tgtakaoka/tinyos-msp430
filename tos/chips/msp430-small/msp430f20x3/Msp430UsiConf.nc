/* -*- mode: nesc; mode: flyspell-prog; -*- */

/* USI pin configuration of MSP430F20x3 */
configuration Msp430UsiC {
    provides {
        interface HplMsp430GeneralIO as USISCLK;
        interface HplMsp430GeneralIO as USISDO;
        interface HplMsp430GeneralIO as USISDI;
        interface HplMsp430GeneralIO as USISCL;
        interface HplMsp430GeneralIO as USISDA;
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;

    USISCLK = IOC.Port15;
    USISDO = IOC.Port16;
    USISDI = IOC.Port17;
    USISCL = IOC.Port16;
    USISDA = IOC.Port17;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
