configuration PlatformClockC {
    uses interface Msp430ClockInit;
}
implementation {
    components PlatformClockP as ClockP;
    components Msp430DcoCalibC;

    Msp430ClockInit = ClockP;
    ClockP.DcoCalib -> Msp430DcoCalibC;
}
