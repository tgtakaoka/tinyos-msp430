interface Msp430VloCalibInfo {
    async command uint16_t getVloFreqKiHz();
    async command uint16_t getMaxDelay();
}
