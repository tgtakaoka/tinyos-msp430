/* -*- mode: nesc; mode: flyspell-prog; -*- */
/*
 * Copyright (C) 2010 Tadashi G. Takaoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module Max7219P
{
    provides interface Led7Seg[int digit];
    uses interface GeneralIO as Data;
    uses interface GeneralIO as Load;
    uses interface GeneralIO as Clock;
    uses interface Boot;
}
implementation
{
    static const uint8_t segments[] = {
        0x7e, 0x30, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x72,
        0x7f, 0x7b, 0x77, 0x1f, 0x4e, 0x3d, 0x4f, 0x47
    };

    void write(unsigned data) {
        int bits = 16;
        atomic {
            call Load.clr();
            do {
                call Clock.clr();
                if (data & 0x8000) {
                    call Data.set();
                } else {
                    call Data.clr();
                }
                call Clock.set();
                data <<= 1;
            } while (--bits != 0);
            call Load.set();
        }
    }

    void normal(unsigned digits) {
        write(0xb00 | (digits - 1));
        write(0xc00 | 1);
    }

    void intensity(unsigned intense) {
        write(0xa00 | intense);
    }

    void mode(unsigned bits) {
        write(0x900 | bits);
    }

    void event Boot.booted() {
        atomic {
            call Load.set();
            call Clock.clr();
            call Load.makeOutput();
            call Clock.makeOutput();
            call Data.makeOutput();
            normal(8);
            mode(0x00);         /* segment mode */
            intensity(15);
        }
    }

    command void Led7Seg.off[int digit]() {
        write(++digit << 8);
    }

    command void Led7Seg.set[int digit](unsigned nibble) {
        write((++digit << 8) | segments[nibble]);
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
