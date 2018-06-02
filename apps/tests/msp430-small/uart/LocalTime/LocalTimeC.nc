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

#include <stdlib.h>
#include "Timer.h"

module LocalTimeC {
    uses interface Boot;
    uses interface StdControl as SerialControl;
    uses interface UartStream;
    uses interface UartByte;
    uses interface Timer<TMilli>;
    uses interface LocalTime<TMilli>;
    uses interface Led;
}
implementation {
    uint16_t prevSec;
    uint8_t message[] = "####\r\n";
    norace uint8_t sendBuf;

    char to(uint8_t v) {
        v &= 0x0f;
        if (v < 10) return v + '0';
        return v + 'A';
    }

    task void sendMessage() {
        uint32_t localtime = call LocalTime.get();
        uint16_t sec = localtime >> 10;
        call Led.set((localtime & 0x3ff) < 100);
        if (sec == prevSec) return;
        prevSec = sec;
        message[0] = to(sec);
        message[1] = to(sec >>= 4);
        message[2] = to(sec >>= 4);
        message[3] = to(sec >>= 4);
        call UartStream.send(message, sizeof(message) - 1);
    }

    async event void UartStream.sendDone(uint8_t* buf, uint16_t len, error_t error) {
    }

    async event void UartStream.receiveDone(uint8_t* buf, uint16_t len, error_t error) {
    }

    task void echoBack() {
        call UartByte.send(sendBuf);
    }

    async event void UartStream.receivedByte(uint8_t byte) { 
        sendBuf = byte;
        post echoBack();
    }

    event void Timer.fired() {
        post sendMessage();
    }

    event void Boot.booted() {
        call Timer.startPeriodic(100);
        call SerialControl.start();
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
