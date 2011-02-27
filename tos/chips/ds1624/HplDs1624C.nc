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

#include "Ds1624.h"

/** An HPL module of DS1624 13-bit Temperature sensor and 256 byte EEPROM
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module HplDs1624C(uint8_t devAddr) {
    provides interface HplDs1624 as Hpl;
    uses interface I2CPacket<TI2CBasicAddr>;
}
implementation {
    enum {
        IDLE = 0,
        CONTINUE = 0x01,
        READ = 0x02,
        WRITE = 0x04,
        WRITE_CMD_ONLY = 0x08,
    };
    norace uint8_t m_state = IDLE;
    uint8_t m_dataLen;
    uint8_t *m_data;
    uint8_t *m_cmd;
    norace error_t m_error;

    command error_t Hpl.read(uint8_t *cmd, uint8_t cmd_len, uint8_t data_len, uint8_t *data) {
        atomic {
            if (m_state != IDLE)
                return EBUSY;
            m_state = READ;
            m_cmd = cmd;
            m_dataLen = data_len;
            m_data = data;
            return call I2CPacket.write(I2C_START, devAddr, cmd_len, cmd);
        }
    }

    command error_t Hpl.write(uint8_t *cmd, uint8_t cmd_len, uint8_t data_len, uint8_t *data) {
        atomic {
            uint8_t flag = I2C_START;
            if (m_state != IDLE)
                return EBUSY;
            if (cmd_len == 0) {
                m_state = WRITE_CMD_ONLY;
                flag |= I2C_STOP;
            } else {
                m_state = WRITE;
            }
            m_cmd = cmd;
            m_dataLen = data_len;
            m_data = data;
            return call I2CPacket.write(flag, devAddr, cmd_len, cmd);
        }
    }

    task void writeDone() {
        signal Hpl.writeDone(m_error, m_cmd, m_dataLen, m_data);
    }

    async event void I2CPacket.writeDone(error_t error, uint16_t chipAddr, uint8_t len,
                                         uint8_t *buf) {
        m_error = error;
        switch (m_state) {
        case READ:
            m_state |= CONTINUE;
            call I2CPacket.read(I2C_START | I2C_STOP, devAddr, m_dataLen, m_data);
            break;
        case WRITE_CMD_ONLY:
            m_state = IDLE;
            post writeDone();
            break;
        case WRITE:
            m_state |= CONTINUE;
            call I2CPacket.write(I2C_STOP, devAddr, m_dataLen, m_data);
            break;
        case WRITE | CONTINUE:
            m_state = IDLE;
            post writeDone();
            break;
        }
    }

    task void readDone() {
        signal Hpl.readDone(m_error, m_cmd, m_dataLen, m_data);
    }

    async event void I2CPacket.readDone(error_t error, uint16_t chipAddr, uint8_t len,
                                        uint8_t *buf) {
        m_error = error;
        switch (m_state) {
        case READ | CONTINUE:
            m_state = IDLE;
            post readDone();
            break;
        }
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
