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

module Msp430DcoCalibP {
    provides interface Msp430DcoCalib as DcoCalib;
    uses {
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
    };

    command void DcoCalib.busyWaitCalibrateDco() {
        const uint16_t saved_bcsctl1 = BCSCTL1 & ~RSEL_MASK;
        uint16_t calib = (RSEL_MAX << 8);
        uint16_t bit = calib;

        call Control.disableEvents();
        call Control.setControlAsCapture(MSP430TIMER_CM_RISING, MSP430TIMER_CCI_B);
        call Timer.setControl(MSP430TIMER_CONTINUOUS_MODE,
                              MSP430TIMER_SMCLK,
                              MSP430TIMER_CLOCKDIV_1);
        call Control.clearPendingInterrupt();
        while (bit != 0) {
            int16_t value;
            BCSCTL1 = XT2OFF | DIVA_3 | (calib >> 8);
            DCOCTL = (calib & 0xff);
            while (!call Control.isInterruptPending())
                ;
            call Control.clearPendingInterrupt();
            value = call Capture.getEvent();
            while (!call Control.isInterruptPending())
                ;
            call Control.clearPendingInterrupt();
            value = call Capture.getEvent() - value;
            value -= DELTA;
            if (value == 0 || value == -1)
                break; // calibrated.
            if (value >= 0) // DCO is too fast.
                calib &= ~bit; // slow down DCO.
            calib |= (bit >>= 1);
#if defined(__MSP430_HAS_BC2__) && defined(CALDCO_16MH_)
            while (calib > ((CALBC1_16MHZ << 8) | CALDCO_16MHZ) && bit != 0) {
                calib &= ~bit;
                calib |= (bit >>= 1);
            }
#endif
        }
        BCSCTL1 = (BCSCTL1 & RSEL_MASK) | saved_bcsctl1;
    }

    async event void Timer.overflow() {}
    async event void Capture.captured(uint16_t time) {}
}
