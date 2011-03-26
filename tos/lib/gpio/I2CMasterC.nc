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

#include "I2CMaster.h"

/** An software I2C master implementation using GPIO.
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */

generic module I2CMasterC(typedef addr_size, int addressing) {
    provides {
        interface StdControl as I2CControl;
        interface I2CPacket<addr_size>;
    }
    uses {
        interface GeneralIO as SCL;
        interface GeneralIO as SDA;
    }
}
implementation {
    norace uint8_t m_length;
    norace uint8_t *m_data;
    norace uint16_t m_addr;

    void delay() {
        int i;
        for (i = 0; i < 100; i++)
            __asm__("nop");
    }

    void setSdaLow() {
        call SDA.makeOutput();
    }

    void setSdaHigh() {
        call SDA.makeInput();
    }

    void setSclLow() {
        call SCL.makeOutput();
    }

    void setSclHigh() {
        call SCL.makeInput();
    }

    uint8_t getSda() {
        call SDA.makeInput();
        return call SDA.get();
    }

    uint8_t getScl() {
        call SCL.makeInput();
        return call SCL.get();
    }

    void sendBit(uint8_t bit) {
        atomic {
            setSclLow();
            delay();
            if (bit) {
                setSdaHigh();
            } else {
                setSdaLow();
            }
            while (getScl() == 0)
                ;
            delay();
        }
    }

    uint8_t receiveBit() {
        atomic {
            setSclLow();
            delay();
            while (getScl() == 0)
                ;
            delay();
            return getSda();
        }
    }

    uint8_t sendByte(uint8_t data) {
        int i;
        for (i = 0; i < 8; i++) {
            sendBit(data & 0x80);
            data <<= 1;
        }
        return receiveBit();
    }

    uint8_t receiveByte(bool nack) {
        uint8_t data = 0;
        int i;
        for (i = 0; i < 8; i++) {
            data <<= 1;
            if (receiveBit() != 0)
                data |= 1;
        }
        sendBit(nack ? 1 : 0);
        return data;
    }

    uint8_t sendAddress(uint16_t addr, int read) {
        if (addressing == I2C_MASTER_BASIC_ADDR) {
            return sendByte(addr << 1 | read);
        } else {
            if (sendByte(0xF0 | ((addr & 0x200) >> 7) | read) != 0)
                return 1;
            return sendByte(addr);
        }
    }

    void i2cStop() {
        setSdaHigh();
    }

    bool i2cStart(uint16_t addr, int read) {
        setSdaLow();
        if (sendAddress(addr, read)) {
            i2cStop();
            return TRUE;
        }
        return FALSE;
    }

    command error_t I2CControl.start() {
        atomic {
            setSdaHigh();
            setSclHigh();
            call SDA.clr();
            call SCL.clr();
        }
        return SUCCESS;
    }

    command error_t I2CControl.stop() {
        return SUCCESS;
    }

    void initState(uint16_t addr, uint8_t length, uint8_t *data) {
        m_addr = addr;
        m_length = length;
        m_data = data;
    }

    task void readDone() {
        signal I2CPacket.readDone(SUCCESS, m_addr, m_length, m_data);
    }

    async command error_t I2CPacket.read(i2c_flags_t flags, uint16_t addr, uint8_t length,
                                         uint8_t *data) {
        int i;
        initState(addr, length, data);

        if (flags & I2C_START) {
            if (i2cStart(addr, 1))
                return ENOACK;
        }

        for (i = 0; i < length; i++) {
            data[i] = receiveByte(i == length - 1 && (flags & I2C_ACK_END) == 0);
        }

        if (flags & I2C_STOP)
            i2cStop();

        post readDone();
        return SUCCESS;
    }

    task void writeDone() {
        signal I2CPacket.writeDone(SUCCESS, m_addr, m_length, m_data);
    }

    async command error_t I2CPacket.write(i2c_flags_t flags, uint16_t addr, uint8_t length,
                                          uint8_t *data) {
        int i;
        initState(addr, length, data);

        if (flags & I2C_START) {
            if (i2cStart(addr, 0))
                return ENOACK;
        }

        for (i = 0; i < length; i++) {
            if (sendByte(data[i]) != 0) {
                i2cStop();
                return ENOACK;
            }
        }

        if (flags & I2C_STOP)
            i2cStop();

        post writeDone();
        return SUCCESS;
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
