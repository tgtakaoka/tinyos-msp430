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

module Msp430CalibrateDcoP {
    uses {
        interface Msp430CalibrateDco as CalibrateDco;
        interface Msp430Timer as Timer;
        interface Msp430TimerControl as Control;
        interface Msp430Capture as Capture;
    }
}
implementation {
    enum {
/*
 * Basic Clock and BC2 differ in the size of the Range Select (RSEL)
 * field.   x1xxx (BASIC_CLOCK) has 3 bits, x2xxx (BC2) has 4 bits.
 * RSEL_MAX denotes where to start for calibration, RSEL_MASK is used
 * to mask the entire RSEL field.
 */
#if defined(__MSP430_HAS_BASIC_CLOCK__)
        RSEL_MASK = (RSEL2 | RSEL1 | RSEL0),
        RSEL_MAX = RSEL2,
#elif defined(__MSP430_HAS_BC2__)
        RSEL_MASK = (RSEL3 | RSEL2 | RSEL1 | RSEL0),
        RSEL_MAX = RSEL3,
#else
#error "Unknown clock system"
#endif
        DELTA = (uint16_t)(TARGET_DCO_HZ / (ACLK_HZ / 8)),
        MAX_LOOP = 10000,
        BCSCTL1_BITS = XT2OFF | DIVA_3, // ACLK = LFXT1 / 8.
    };

    event void CalibrateDco.busyWaitCalibrateDco() {
        const uint16_t saved_bcsctl1 = BCSCTL1 & ~RSEL_MASK;
        uint16_t previous;
        int16_t loop;

        BCSCTL1 = BCSCTL1_BITS | RSEL_MAX;
        call Control.disableEvents();
        call Control.setControlAsCapture(MSP430TIMER_CM_RISING, MSP430TIMER_CCI_B);
        call Timer.setControl(MSP430TIMER_CONTINUOUS_MODE,
                              MSP430TIMER_SMCLK,
                              MSP430TIMER_CLOCKDIV_1);
        while (!call Control.isInterruptPending())
            ;
        call Control.clearPendingInterrupt();
        previous = call Capture.getEvent();
        for (loop = 0; loop < MAX_LOOP; loop++) {
            int16_t value;
            while (!call Control.isInterruptPending())
                ;
            call Control.clearPendingInterrupt();
            value = call Capture.getEvent() - previous;
            previous = call Capture.getEvent();
            value -= DELTA;
            if (value == 0 || value == -1)
                break; // calibrated.
            if (value < 0) {
                if (++DCOCTL == 0) {
                    if (BCSCTL1 == (BCSCTL1_BITS | RSEL_MASK)) {
                        DCOCTL = 0xff; // set fastest DCO.
                        break;
                    }
                    BCSCTL1++;
                }
#if defined(__MSP430_HAS_BC2__) && defined(CALDCO_16MH_)
                if (DCOCTL == CALDCO_16MHZ
                    && BCSCTL1 == (BCSCTL1_BITS | CALBC1_16MHZ)) {
                    break; // fastest DCO.
                }
#endif
            } else {
                if (--DCOCTL == 0) {
                    if ((BCSCTL1 & RSEL_MASK) == 0) {
                        DCOCTL = 0; // set slowest DCO.
                        break;
                    }
                    BCSCTL1--;
                }
            }
        }
        BCSCTL1 = (BCSCTL1 & RSEL_MASK) | saved_bcsctl1;
    }

    async event void Timer.overflow() {}
    async event void Capture.captured(uint16_t time) {}
}
