/*
 * Copyright (c) 2018 Tadashi G. Takaoka
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */

configuration Msp430DcoCalib32khzP {
    uses interface Msp430DcoCalib as DcoCalib;
}
implementation {
    components Msp430DcoCalibP, Msp430TimerC;

    DcoCalib = Msp430DcoCalibP;

    Msp430DcoCalibP.Timer -> Msp430TimerC.TimerA;
#if defined(__MSP430_HAS_TA2__)
    Msp430DcoCalibP.Control -> Msp430TimerC.ControlA0;
    Msp430DcoCalibP.Capture -> Msp430TimerC.CaptureA0;
#elif defined(__MSP430_HAS_TA3__)
#if defined(__MSP430G2402) || defined(__MSP430G2452) || defined(__MSP430G2553)
    /* Some MSP430G2xx have TA3 but ACLK is connected to CCR0.CCIB */
    Msp430DcoCalibP.Control -> Msp430TimerC.ControlA0;
    Msp430DcoCalibP.Capture -> Msp430TimerC.CaptureA0;
#else
    Msp430DcoCalibP.Control -> Msp430TimerC.ControlA2;
    Msp430DcoCalibP.Capture -> Msp430TimerC.CaptureA2;
#endif
#endif
}
