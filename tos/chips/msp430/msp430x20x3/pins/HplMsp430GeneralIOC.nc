#include "msp430port_compat.h"

configuration HplMsp430GeneralIOC
{
#ifdef __msp430_have_port1
    provides interface HplMsp430GeneralIO as Port10;
    provides interface HplMsp430GeneralIO as Port11;
    provides interface HplMsp430GeneralIO as Port12;
    provides interface HplMsp430GeneralIO as Port13;
    provides interface HplMsp430GeneralIO as Port14;
    provides interface HplMsp430GeneralIO as Port15;
    provides interface HplMsp430GeneralIO as Port16;
    provides interface HplMsp430GeneralIO as Port17;
#endif

#ifdef __msp430_have_port2
#if !defined(__msp430x20x3)
    provides interface HplMsp430GeneralIO as Port20;
    provides interface HplMsp430GeneralIO as Port21;
    provides interface HplMsp430GeneralIO as Port22;
    provides interface HplMsp430GeneralIO as Port23;
    provides interface HplMsp430GeneralIO as Port24;
    provides interface HplMsp430GeneralIO as Port25;
#endif
    provides interface HplMsp430GeneralIO as Port26;
    provides interface HplMsp430GeneralIO as Port27;
#endif
}
implementation
{
#ifdef __msp430_have_port1
    components
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 0) as P10,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 1) as P11,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 2) as P12,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 3) as P13,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 4) as P14,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 5) as P15,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 6) as P16,
        new HplMsp430GeneralIOP(P1IN_, P1OUT_, P1DIR_, P1SEL_, 7) as P17;
#endif

#ifdef __msp430_have_port2
    components
#if !defined(__msp430x20x3)
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 0) as P20,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 1) as P21,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 2) as P22,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 3) as P23,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 4) as P24,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 5) as P25,
#endif
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 6) as P26,
        new HplMsp430GeneralIOP(P2IN_, P2OUT_, P2DIR_, P2SEL_, 7) as P27;
#endif

#ifdef __msp430_have_port1
    Port10 = P10;
    Port11 = P11;
    Port12 = P12;
    Port13 = P13;
    Port14 = P14;
    Port15 = P15;
    Port16 = P16;
    Port17 = P17;
#endif

#ifdef __msp430_have_port2
#if !defined(__msp430x20x3)
    Port20 = P20;
    Port21 = P21;
    Port22 = P22;
    Port23 = P23;
    Port24 = P24;
    Port25 = P25;
#endif
    Port26 = P26;
    Port27 = P27;
#endif
}
