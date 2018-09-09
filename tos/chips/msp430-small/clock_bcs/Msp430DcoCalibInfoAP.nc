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

module Msp430DcoCalibInfoAP {
    provides interface Msp430DcoCalib as DcoCalib;
}
implementation {
    command void DcoCalib.busyWaitCalibrateDco() {
#if TARGET_DCO_HZ == (16 * 1024UL * 1024UL) && defined(CALDCO_16MHZ_)
        DCOCTL = CALDCO_16MHZ;
        BCSCTL1 = CALBC1_16MHZ;
#elif TARGET_DCO_HZ == (12 * 1024UL * 1024UL) && defined(CALDCO_12MHZ_)
        DCOCTL = CALDCO_12MHZ;
        BCSCTL1 = CALBC1_12MHZ;
#elif TARGET_DCO_HZ == (8 * 1024UL * 1024UL) && defined(CALDCO_8MHZ_)
        DCOCTL = CALDCO_8MHZ;
        BCSCTL1 = CALBC1_8MHZ;
#elif TARGET_DCO_HZ == (1 * 1024UL * 1024UL) && defined(CALDCO_1MHZ_)
        DCOCTL = CALDCO_1MHZ;
        BCSCTL1 = CALBC1_1MHZ;
#else
#error "TARGET_DCO_HZ is " TARGET_DCO_HZ ", but no CALDCO/CALBC1 value defined"
#endif
    }
}
