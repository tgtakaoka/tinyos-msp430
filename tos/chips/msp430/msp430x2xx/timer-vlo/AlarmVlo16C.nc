generic configuration AlarmVlo16C()
{
    provides interface Init;
    provides interface Alarm<TVlo,uint16_t>;
}
implementation
{
    components new Msp430TimerVloC() as Msp430Timer;
    components new Msp430AlarmC(TVlo) as Msp430Alarm;

    Init = Msp430Alarm;
    Alarm = Msp430Alarm;

    Msp430Alarm.Msp430Timer -> Msp430Timer;
    Msp430Alarm.Msp430TimerControl -> Msp430Timer;
    Msp430Alarm.Msp430Compare -> Msp430Timer;
}
