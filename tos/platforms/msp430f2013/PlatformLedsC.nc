#include "hardware.h"

configuration PlatformLedsC
{
    provides interface GeneralIO as Led0;
    provides interface GeneralIO as Led1;
    provides interface GeneralIO as Led2;
    uses interface Init;
}
implementation
{
    components HplMsp430GeneralIOC as GeneralIOC;
    components new Msp430GpioC() as Led0Impl;
    components new Msp430GpioC() as Led1Impl;
    components new Msp430GpioC() as Led2Impl;
    components new InvertGeneralIO() as Led0Inv;
    components new InvertGeneralIO() as Led1Inv;
    components new InvertGeneralIO() as Led2Inv;
    components PlatformP;

    Init = PlatformP.LedsInit;

    Led0 = Led0Inv;
    Led0Inv.Impl -> Led0Impl;
    Led0Impl -> GeneralIOC.Port10;

    Led1 = Led1Inv;
    Led1Inv.Impl -> Led1Impl;
    Led1Impl -> GeneralIOC.Port11;

    Led2 = Led2Inv;
    Led2Inv.Impl -> Led2Impl;
    Led2Impl -> GeneralIOC.Port12;
}
