generic configuration Msp430TimerVloC()
{
    provides interface Msp430Timer;
    provides interface Msp430TimerControl;
    provides interface Msp430Compare;
}
implementation
{
    components Msp430TimerVloMapC as Map;

    enum { ALARM_ID = unique("Msp430TimerVloMapC") };

    Msp430Timer = Map.Msp430Timer[ALARM_ID];
    Msp430TimerControl = Map.Msp430TimerControl[ALARM_ID];
    Msp430Compare = Map.Msp430Compare[ALARM_ID];
}
