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

/** An module of DS1624 13-bit Temperature sensor and 256 byte EEPROM
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */

generic module Ds1624P() {
    provides interface Ds1624;
    uses interface HplDs1624 as Hpl;
}
implementation {
    uint8_t m_buf[2];

    command error_t Ds1624.readTemperature(uint8_t *temperature) {
        m_buf[0] = DS1624_COMMAND_READ_TEMPERATURE;
        return call Hpl.read(m_buf, 1, 2, temperature);
    }

    command error_t Ds1624.startConversion() {
        m_buf[0] = DS1624_COMMAND_START_CONVERT;
        return call Hpl.write(m_buf, 1, 0, NULL);
    }

    command error_t Ds1624.stopConversion() {
        m_buf[0] = DS1624_COMMAND_STOP_CONVERT;
        return call Hpl.write(m_buf, 1, 0, NULL);
    }

    command error_t Ds1624.readConfig() {
        m_buf[0] = DS1624_COMMAND_ACCESS_CONFIG;
        return call Hpl.read(m_buf, 1, 1, m_buf + 1);
    }

    command error_t Ds1624.writeConfig(uint8_t config) {
        m_buf[0] = DS1624_COMMAND_ACCESS_CONFIG;
        m_buf[1] = config;
        return call Hpl.write(m_buf, 2, 0, NULL);
    }

    command error_t Ds1624.readMemory(uint8_t memAddr, uint8_t data_len, uint8_t *data) {
        m_buf[0] = DS1624_COMMAND_ACCESS_MEMORY;
        m_buf[1] = memAddr;
        return call Hpl.read(m_buf, 2, data_len, data);
    }

    command error_t Ds1624.writeMemory(uint8_t memAddr, uint8_t data_len, uint8_t *data) {
        m_buf[0] = DS1624_COMMAND_ACCESS_MEMORY;
        m_buf[1] = memAddr;
        return call Hpl.write(m_buf, 2, data_len, data);
    }

    event void Hpl.readDone(error_t error, uint8_t *cmd, uint8_t data_len, uint8_t *data) {
        switch (cmd[0]) {
        case DS1624_COMMAND_READ_TEMPERATURE:
            signal Ds1624.readTemperatureDone(error, data);
            break;
        case DS1624_COMMAND_ACCESS_CONFIG:
            signal Ds1624.readConfigDone(error, m_buf[1]);
            break;
        case DS1624_COMMAND_ACCESS_MEMORY:
            signal Ds1624.readMemoryDone(error, cmd[1], data_len, data);
            break;
        }
    }

    event void Hpl.writeDone(error_t error, uint8_t *cmd, uint8_t data_len, uint8_t *data) {
        switch (cmd[0]) {
        case DS1624_COMMAND_START_CONVERT:
            signal Ds1624.startConversionDone(error);
            break;
        case DS1624_COMMAND_STOP_CONVERT:
            signal Ds1624.stopConversionDone(error);
            break;
        case DS1624_COMMAND_ACCESS_CONFIG:
            signal Ds1624.writeConfigDone(error);
            break;
        case DS1624_COMMAND_ACCESS_MEMORY:
            signal Ds1624.writeMemoryDone(error, cmd[1], data_len, data);
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
