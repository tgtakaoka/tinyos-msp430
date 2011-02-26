/* -*- mode: nesc; mode: flyspell-prog; -*- */

module UsiConf {
    provides interface StdControl as SpiControl;
    provides interface Msp430SpiConfigure;
    uses interface Resource as SpiResource;
}
implementation {
    const msp430_spi_union_config_t spi_config = {
        {
        usimst    : 1,            // master
        usilsb    : 0,            // msb first
        usickpl   : 0,
        usickph   : 1,
        usissel   : 2,            // SMCLK
        usidiv    : 1,            // SMCLK/2
        }
    };

    command error_t SpiControl.start() {
        return call SpiResource.immediateRequest();
    }

    command error_t SpiControl.stop() {
        call SpiResource.release();
        return SUCCESS;
    }

    event void SpiResource.granted() {}

    async command const msp430_spi_union_config_t* Msp430SpiConfigure.getConfig() {
        return &spi_config;
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
