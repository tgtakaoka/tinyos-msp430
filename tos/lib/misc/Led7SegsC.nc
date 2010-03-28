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

generic module Led7SegsC(char name[], int numDigits, typedef size_type @integer())
{
    provides interface Led7Segs<size_type>;
    uses interface Led7Seg[int digits];
}
implementation
{
    enum {
        OFFSET = uniqueN(name, numDigits),
    };

    command void Led7Segs.off() {
        int i;
        for (i = 0; i < numDigits; i++)
            call Led7Seg.off[OFFSET + i]();
    }

    command void Led7Segs.dec(size_type val) {
        int i;
        bool suppress = FALSE;
        for (i = 0; i < numDigits; i++) {
            if (suppress) {
                call Led7Seg.off[OFFSET + i]();
            } else {
                call Led7Seg.set[OFFSET + i](val % 10);
            }
            if ((val /= 10) == 0)
                suppress = TRUE;
        }
    }

    command void Led7Segs.dec0(size_type val) {
        int i;
        for (i = 0; i < numDigits; i++) {
            call Led7Seg.set[OFFSET + i](val % 10);
            val /= 10;
        }
    }

    command void Led7Segs.hex(size_type val) {
        int i;
        for (i = 0; i < numDigits; i++) {
            call Led7Seg.set[OFFSET + i](val % 16);
            val /= 16;
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
