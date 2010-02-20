configuration Blink1Sec16AppC
{
}
implementation
{
    components MainC, Blink1Sec16C, LedsC;
    components new TimerMilli16C() as Timer16;

    Blink1Sec16C -> MainC.Boot;

    Blink1Sec16C.Timer16 -> Timer16;
    Blink1Sec16C.Leds -> LedsC;
}
