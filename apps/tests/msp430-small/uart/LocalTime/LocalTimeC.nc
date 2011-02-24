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

#include "Timer.h"

module LocalTimeC {
    uses interface Boot;
    uses interface StdControl as UartControl;
    uses interface UartStream;
    uses interface Timer<TMilli>;
    uses interface LocalTime<TMilli>;
    uses interface Led;
}
implementation {
    uint8_t prevSec = -1;
    uint8_t message[] = "HH:MM:SS\r\n";

    uint8_t *getSendBuf() {
        return message + sizeof(message) - 1;
    }

    void dec2(uint8_t *p, uint16_t v) {
        p[0] = v / 10 + '0';
        p[1] = v % 10 + '0';
    }

    task void sendMessage() {
        uint32_t time;
        uint8_t sec;
        time = call LocalTime.get();
        call Led.set(time % 1000 < 100);

        sec = (time /= 1000) % 60;
        if (sec == prevSec)
            return;

        prevSec = sec;
        dec2(message + 6, sec);
        dec2(message + 3, (time /= 60) % 60);
        dec2(message + 0, (time /= 60) % 24);
        call UartStream.send(message, sizeof(message) - 1);
    }

    task void echoBack() {
        uint8_t *sendBuf = getSendBuf();
        if (*sendBuf == '\r' || *sendBuf == '\n') {
            call UartStream.send(sendBuf - 2, 2);
        } else {
            call UartStream.send(sendBuf, 1);
        }
    }

    async event void UartStream.receivedByte(uint8_t byte) { 
        *getSendBuf() = byte;
        post echoBack();
    }

    async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error) {}

    async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error) {}

    event void Timer.fired() {
        post sendMessage();
    }

    event void Boot.booted() {
        call UartControl.start();
        call Timer.startPeriodic(100);
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
