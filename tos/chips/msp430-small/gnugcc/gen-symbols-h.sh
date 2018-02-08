#!/bin/bash
#
# Script to generate <mcu>_symbols.h from <mcu>_symbols.ld comes from
# TI's gcc support files.

gcc=$(which msp430-elf-gcc)
include=${gcc%/bin/msp430-elf-gcc}/msp430-gcc-support-files/include

echo "##### Generate iomacros.h from ${include}/iomacros.h" 1>&2
sed -e 's/unsigned long int/uint32_t/' \
    -e 's/unsigned int/uint16_t/' \
    -e 's/unsigned char/uint8_t/' \
    ${include}/iomacros.h > iomacros.h

echo "##### Generate msp430mcu.h from ${include}/msp430.h" 1>&2
awk '
    { print; }
    /^#include/ { sub("\.h", "_symbols.h", $2); print; }' \
    ${include}/msp430.h > msp430mcu.h

target_dirs=($TINYOS_ROOT_DIR/support/make/targets)
[[ -n $TINYOS_ROOT_DIR_ADDITIONAL ]] \
    && target_dirs+=($TINYOS_ROOT_DIR_ADDITIONAL/support/make/targets)
mcu_list=(
    $(egrep -h MSP_MCU $(find "${target_dirs[@]}" -name *.target) \
	     | sed -E 's/MSP_MCU *[?:]?= *(.*)$/\1/' \
	     | sort -u)
)
echo "##### MSP430 targets: ${mcu_list[@]}" 1>&2
for mcu in "${mcu_list[@]}"; do
    symbols=${include}/${mcu}_symbols.ld
    [[ -f ${symbols} ]] || continue
    echo "##### Generate ${mcu}_symbols.h from ${symbols}" 1>&2
    sed -E 's/PROVIDE\(([A-Z0-9_]+)\s*=\s*([0-9A-Fx]+)\);/#define \1_\t\2/' \
	${symbols} > ${mcu}_symbols.h
done
