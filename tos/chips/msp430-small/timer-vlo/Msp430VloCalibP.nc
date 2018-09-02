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

module Msp430VloCalibP {
    provides {
        interface Msp430VloCalib as VloCalib;
        interface Msp430VloCalibInfo as VloCalibInfo;
    }
    uses {
        interface Msp430Timer as Timer;
        interface Msp430TimerControl as Control;
        interface Msp430Capture as Capture;
    }
}
implementation {
    uint16_t m_vlo_microsec_x8;
    uint16_t m_kihz;
    uint16_t m_max_delay;

    command void VloCalib.busyWaitCalibrateVlo() {
        uint16_t value;
        BCSCTL1 = CALBC1_1MHZ | DIVA_3; // DCO = 1MHz, ACLK = VLO/8
        DCOCTL = CALDCO_1MHZ;
        BCSCTL2 = 0;
        BCSCTL3 = LFXT1S_2;     // ACLK = VLO
        call Control.disableEvents();
        call Control.setControlAsCapture(MSP430TIMER_CM_RISING, MSP430TIMER_CCI_B);
        call Timer.setControl(MSP430TIMER_CONTINUOUS_MODE,
                              MSP430TIMER_SMCLK,
                              MSP430TIMER_CLOCKDIV_1);

        call Control.clearPendingInterrupt();
        while (!call Control.isInterruptPending())
            ;
        call Control.clearPendingInterrupt();
        while (!call Control.isInterruptPending())
            ;
        value = call Capture.getEvent();
        call Control.clearPendingInterrupt();
        while (!call Control.isInterruptPending())
            ;
        m_vlo_microsec_x8 = call Capture.getEvent() - value;
        call Timer.setMode(MSP430TIMER_STOP_MODE);

        m_kihz = (m_vlo_microsec_x8 / 8) >> 10;
        m_max_delay = 0x8000 / m_kihz;
    }

    async event void Timer.overflow() {}
    async event void Capture.captured(uint16_t time) {}

    async command uint16_t VloCalibInfo.getVloFreqKiHz() {
        return m_kihz;
    }

    async command uint16_t VloCalibInfo.getMaxDelay() {
        return m_max_delay;
    }
}
