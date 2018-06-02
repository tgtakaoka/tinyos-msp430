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

/** HPL module of DS1624 12-bit Temperature sensor and 256 byte EEPROM
 *
 * @author Tadashi G. Takaoka <tadashi.g.takaoka@gmail.com>
 */
generic module HplDs1624P(uint8_t devAddr) {
    provides interface HplDs1624 as Hpl;
    uses {
        interface I2CPacket<TI2CBasicAddr>;
        interface Resource as I2CResource;
    }
}
implementation {
    enum {
        DEV_ADDR = 0x48 + (devAddr & 0x7),
    };
    norace uint8_t m_flags;
    norace uint8_t *m_buf;
    norace uint8_t m_len;

    command error_t Hpl.write(uint8_t i2c_flags, uint8_t *buf, uint8_t len) {
        m_flags = i2c_flags;
        m_buf = buf;
        m_len = len;
        return call I2CResource.request();
    }

    command error_t Hpl.read(uint8_t *buf, uint8_t len) {
        m_flags = I2C_RESTART | I2C_STOP;
        m_buf = buf;
        m_len = len;
        return call I2CResource.request();
    }

    event void I2CResource.granted() {
        const uint8_t i2c_flags = m_flags;
        if (i2c_flags & I2C_RESTART) {
            call I2CPacket.read(i2c_flags, DEV_ADDR, m_len, m_buf);
        } else {
            call I2CPacket.write(i2c_flags, DEV_ADDR, m_len, m_buf);
        }
    }

    task void releaseResource() {
        m_flags = 0;
        call I2CResource.release();
    }

    async event void I2CPacket.writeDone(error_t error, uint16_t chipAddr, uint8_t len,
                                         uint8_t *buf) {
        if (m_flags & I2C_STOP)
            post releaseResource();
        signal Hpl.writeDone(error, buf, len);
    }

    async event void I2CPacket.readDone(error_t error, uint16_t chipAddr, uint8_t len,
                                        uint8_t *buf) {
        if (m_flags & I2C_STOP)
            post releaseResource();
        signal Hpl.readDone(error, buf, len);
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
