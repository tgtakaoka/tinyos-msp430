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
    uses {
        interface Led7Segs<uint16_t> as Temp;
        interface Led7Segs<uint16_t> as Frac;
        interface Led7Segs<uint16_t> as CentiSec;
        interface Led;
        interface Boot;
        interface StdControl as I2CControl;
        interface Ds1624;
        interface Timer16<TMilli> as Timer16;
    }
}
implementation {
    uint8_t centiSec;

    event void Boot.booted() {
        call Timer16.startPeriodic(100);
        call I2CControl.start();
        call Ds1624.setOneshotMode();
    }

    event void Ds1624.setOneshotModeDone(error_t error) {
        call Ds1624.startConvert();
    }

    event void Timer16.fired() {
        ++centiSec;
        call CentiSec.decimal0(centiSec);
        call Ds1624.readTemperature();
        call Ds1624.startConvert();
    }

    event void Ds1624.startConvertDone(error_t error) {
        call Led.toggle();
    }
    
    event void Ds1624.readTemperatureDone(error_t error, uint16_t temp) {
        call Temp.decimal(temp >> 8);
        call Frac.decimal0(((temp & 0xff) * 100) / 256);
    }

    event void Ds1624.stopConvertDone(error_t error) {}
    event void Ds1624.setContinuousModeDone(error_t error) {}
    event void Ds1624.getStatusDone(error_t error, bool conversionDone) {}
    event void Ds1624.readMemoryDone(error_t error, uint8_t memAddr, uint8_t *buf, uint8_t len) {}
    event void Ds1624.writeMemoryDone(error_t error, uint8_t memAddr, uint8_t *buf, uint8_t len) {}
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
