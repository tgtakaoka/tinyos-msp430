configuration Blink1SecAppC
{
}
implementation
{
    components MainC, Blink1SecC, LedsC;
    components new TimerMilliC() as Timer;

    Blink1SecC -> MainC.Boot;

    Blink1SecC.Timer -> Timer;
    Blink1SecC.Leds -> LedsC;
}
