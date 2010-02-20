configuration Msp430ClockC
{
    provides interface Init;
    provides interface Msp430ClockInit;
}
implementation
{
    components Msp430ClockP;
    components McuSleepC;

    Init = Msp430ClockP;
    Msp430ClockInit = Msp430ClockP;
    McuSleepC.McuPowerOverride -> Msp430ClockP;
}
