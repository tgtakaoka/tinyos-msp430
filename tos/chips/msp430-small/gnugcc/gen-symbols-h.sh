#!/bin/bash
#
# Script to generate <mcu>_symbols.h from <mcu>_symbols.ld comes from
# TI's gcc support files.

brew=$(brew --prefix)
include=${brew}/include/msp430-elf/include
lib=${brew}/lib/msp430-elf/lib

echo "##### Copy gnugcc/devices.csv from ${include}/devices.csv" 1>&2
cp -p ${include}/devices.csv .

echo "##### Generate gnugcc/iomacros.h from ${include}/iomacros.h" 1>&2
sed -e 's/unsigned long int/uint32_t/' \
    -e 's/unsigned int/uint16_t/' \
    -e 's/unsigned char/uint8_t/' \
    ${include}/iomacros.h > iomacros.h

echo "##### Generate gnugcc/msp430.h from ${include}/msp430.h" 1>&2
cat ${include}/msp430.h | \
tr -d '\015' | \
awk '
    {  print; }
    /^#include/ { sub("\\.h", "_symbols.h", $2); print; }' \
    > msp430.h

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
    symbols=${lib}/${mcu}_symbols.ld
    [[ -f ${symbols} ]] || continue
    echo "##### Generate ${mcu}_symbols.h from ${symbols}" 1>&2
    sed -E 's/PROVIDE\(([A-Z0-9_]+) *= *([0-9A-Fx]+)\);/#define \1_	\2/' \
	${symbols} > ${mcu}_symbols.h
done
