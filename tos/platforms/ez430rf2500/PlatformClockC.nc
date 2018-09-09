configuration PlatformClockC {
    uses interface Msp430ClockInit;
}
implementation {
    components PlatformClockVloP as ClockP;
    components Msp430DcoCalibC;

    Msp430ClockInit = ClockP;
    ClockP.DcoCalib -> Msp430DcoCalibC;
}
