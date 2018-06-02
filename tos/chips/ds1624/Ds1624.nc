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

/** An interface of DS1624 12-bit Temperature sensor and 256 byte EEPROM
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
interface Ds1624 {
    command error_t readTemperature();
    command error_t startConvert();
    command error_t stopConvert();
    command error_t setOneshotMode();
    command error_t setContinuousMode();
    command error_t getStatus();
    command error_t readMemory(uint8_t memAddr, uint8_t *buf, uint8_t len);
    command error_t writeMemory(uint8_t memAddr, uint8_t *buf, uint8_t len);

    event void readTemperatureDone(error_t error, uint16_t temperature);
    event void startConvertDone(error_t error);
    event void stopConvertDone(error_t error);
    event void setOneshotModeDone(error_t error);
    event void setContinuousModeDone(error_t error);
    event void getStatusDone(error_t error, bool conversionDone);
    event void readMemoryDone(error_t error, uint8_t memAddr, uint8_t *buf, uint8_t len);
    event void writeMemoryDone(error_t error, uint8_t memAddr, uint8_t *buf, uint8_t len);
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
