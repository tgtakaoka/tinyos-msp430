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

/** A module of DS1624 12-bit Temperature sensor and 256 byte EEPROM
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */

generic module Ds1624P() {
    provides interface Ds1624;
    uses {
        interface HplDs1624 as Hpl;
        interface Timer16<TMilli> as Timer16;
    }
}
implementation {
    enum {
        // Commands.
        READ_TEMPERATURE = 0xaa,
        START_CONVERT    = 0xee,
        STOP_CONVERT     = 0x22,
        ACCESS_MEMORY    = 0x17,
        ACCESS_CONFIG    = 0xac,
        // Bit definition of Config register.
        CONFIG_MAGIC     = 0x0a,
        CONFIG_DONE      = 0x80,
        CONFIG_ONE_SHOT  = 0x01,
    };
    enum state {
        IDLE = 0,
        GET_TEMP,
        START_CONV,
        STOP_CONV,
        GET_STAT,
        SET_ONESHOT,
        SET_CONTINUOUS,
        GET_MEM_ADDR,
        GET_MEM_DATA,
        SET_MEM_ADDR,
        SET_MEM_DATA,
    };

    norace enum state m_state = IDLE;
    uint8_t m_cmd[2];
    uint8_t m_memAddr;
    uint8_t *m_buf;
    uint8_t m_len;
    norace error_t m_error;

    static bool setState(enum state state) {
        bool res = FALSE;
        atomic {
            if (m_state == IDLE) {
                m_state = state;
                res = TRUE;
            }
        }
        return res;
    }

    command error_t Ds1624.readTemperature() {
        if (!setState(GET_TEMP))
            return EBUSY;
        m_cmd[0] = READ_TEMPERATURE;
        return call Hpl.write(I2C_START, m_cmd, 1);
    }

    command error_t Ds1624.startConvert() {
        if (!setState(START_CONV))
            return EBUSY;
        m_cmd[0] = START_CONVERT;
        return call Hpl.write(I2C_START | I2C_STOP, m_cmd, 1);
    }

    command error_t Ds1624.stopConvert() {
        if (!setState(STOP_CONV))
            return EBUSY;
        m_cmd[0] = STOP_CONVERT;
        return call Hpl.write(I2C_START | I2C_STOP, m_cmd, 1);
    }

    command error_t Ds1624.setOneshotMode() {
        if (!setState(SET_ONESHOT))
            return EBUSY;
        m_cmd[0] = ACCESS_CONFIG;
        m_cmd[1] = CONFIG_MAGIC | CONFIG_ONE_SHOT;
        return call Hpl.write(I2C_START | I2C_STOP, m_cmd, 2);
    }

    command error_t Ds1624.setContinuousMode() {
        if (!setState(SET_CONTINUOUS))
            return EBUSY;
        m_cmd[0] = ACCESS_CONFIG;
        m_cmd[1] = CONFIG_MAGIC;
        return call Hpl.write(I2C_START | I2C_STOP, m_cmd, 2);
    }

    command error_t Ds1624.getStatus() {
        if (!setState(GET_STAT))
            return EBUSY;
        m_cmd[0] = ACCESS_CONFIG;
        return call Hpl.write(I2C_START, m_cmd, 1);
    }

    command error_t Ds1624.readMemory(uint8_t memAddr, uint8_t *buf, uint8_t len) {
        if (!setState(GET_MEM_ADDR))
            return EBUSY;
        m_cmd[0] = ACCESS_MEMORY;
        m_cmd[1] = memAddr;
        m_memAddr = memAddr;
        m_buf = buf;
        m_len = len;
        return call Hpl.write(I2C_START, m_cmd, 2);
    }

    command error_t Ds1624.writeMemory(uint8_t memAddr, uint8_t *buf, uint8_t len) {
        if (!setState(SET_MEM_ADDR))
            return EBUSY;
        m_cmd[0] = ACCESS_MEMORY;
        m_cmd[1] = memAddr;
        m_memAddr = memAddr;
        m_buf = buf;
        m_len = len;
        return call Hpl.write(I2C_START, m_cmd, 2);
    }

    task void signalEvent() {
        enum state state = m_state;
        error_t error = m_error;
        switch (state) {
        default: {
            m_state = IDLE;
            switch (state) {
            case START_CONV:
                signal Ds1624.startConvertDone(error);
                return;
            case STOP_CONV:
                signal Ds1624.stopConvertDone(error);
                return;
            case SET_ONESHOT:
                signal Ds1624.setOneshotModeDone(error);
                return;
            case SET_CONTINUOUS:
                signal Ds1624.setContinuousModeDone(error);
                return;
            }
            break;
        }
        case GET_TEMP: {
            uint16_t temp = (uint16_t)m_buf[0] << 8;
            temp |= m_buf[1];
            m_state = IDLE;
            signal Ds1624.readTemperatureDone(error, temp);
            return;
        }
        case GET_STAT: {
            bool done = (m_buf[0] & CONFIG_DONE) != 0;
            m_state = IDLE;
            signal Ds1624.getStatusDone(error, done);
            return;
        }
        case GET_MEM_DATA:
        case SET_MEM_DATA: {
            uint8_t memAddr = m_memAddr;
            uint8_t *buf = m_buf;
            uint8_t len = m_len;
            m_state = IDLE;
            if (state == GET_MEM_DATA) {
                signal Ds1624.readMemoryDone(error, memAddr, buf, len);
            } else {
                signal Ds1624.writeMemoryDone(error, memAddr, buf, len);
            }
            return;
        }
        }
    }

    async event void Hpl.writeDone(error_t error, uint8_t *buf, uint8_t len) {
        switch (m_state) {
        case GET_TEMP:
            call Hpl.read(m_buf, m_len);
            break;
        case START_CONV:
        case STOP_CONV:
        case SET_ONESHOT:
        case SET_CONTINUOUS:
            post signalEvent();
            break;
        case GET_STAT:
            call Hpl.read(m_cmd, 1);
            break;
        case GET_MEM_ADDR:
            m_state = GET_MEM_DATA;
            call Hpl.read(m_buf, m_len);
            break;
        case SET_MEM_ADDR:
            m_state = SET_MEM_DATA;
            call Hpl.write(I2C_STOP, m_buf, m_len);
            break;
        case SET_MEM_DATA:
            call Timer16.startOneShot(100);
            break;
        }
    }

    async event void Hpl.readDone(error_t error, uint8_t *buf, uint8_t len) {
        m_error = error;
        post signalEvent();
    }

    event void Timer16.fired() {
        m_error = SUCCESS;
        post signalEvent();
    }

    default event void Ds1624.startConvertDone(error_t error) {}
    default event void Ds1624.stopConvertDone(error_t error) {}
    default event void Ds1624.setOneshotModeDone(error_t error) {}
    default event void Ds1624.setContinuousModeDone(error_t error) {}
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
