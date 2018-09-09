module PlatformNullP {
    provides interface Platform;
}
implementation {
    async command uint32_t Platform.localTime()      { return 0; }
    async command uint32_t Platform.usecsRaw()       { return 0; }
    async command uint32_t Platform.usecsRawSize()   { return 0; }
    async command uint32_t Platform.jiffiesRaw()     { return 0; }
    async command uint32_t Platform.jiffiesRawSize() { return 0; }
    async command bool     Platform.set_unaligned_traps(bool on_off) {
        return FALSE;
    }
    async command int Platform.getIntPriority(int irq_number) { return irq_number; }
}
