/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2011, Tadashi G. Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module TemperatureC {
    uses interface Led7Segs<uint16_t> as Temp;
    uses interface Led7Segs<uint16_t> as Frac;
    uses interface Led7Segs<uint16_t> as Min;
    uses interface Led7Segs<uint16_t> as Sec;
    uses interface Led;
    uses interface Timer16<TMilli> as Timer;
    uses interface Boot;
    uses interface Ds1624;
}
implementation {
    uint8_t deciSec;
    uint8_t sec;
    uint8_t min;
    uint8_t temp[2];

    event void Boot.booted() {
        call Timer.startPeriodic(100);
    }

    event void Timer.fired() {
        ++deciSec;
        if (deciSec == 10) {
            call Ds1624.readTemperature(temp);
            deciSec = 0;
            ++sec;
            if (sec == 60) {
                sec = 0;
                min++;
                if (min == 60) {
                    min = 0;
                }
            }
        }
//        call Led.set(deciSec < 1);
        call Sec.decimal0(sec);
        call Min.decimal0(min);
        call Temp.decimal(temp[0]);
        call Frac.decimal0((temp[1] * 100) / 256);
    }

    event void Ds1624.readTemperatureDone(error_t error, uint8_t *temperature) {
        call Led.toggle();
    }

    event void Ds1624.startConversionDone(error_t error) {}
    event void Ds1624.stopConversionDone(error_t error) {}
    event void Ds1624.readConfigDone(error_t error, uint8_t config) {}
    event void Ds1624.writeConfigDone(error_t error) {}
    event void Ds1624.readMemoryDone(error_t error, uint8_t memAddr, uint8_t data_len,
                                     uint8_t *data) {}
    event void Ds1624.writeMemoryDone(error_t error, uint8_t memAddr, uint8_t data_len,
                                      uint8_t *data) {}
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
