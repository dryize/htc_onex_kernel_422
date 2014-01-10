#!/bin/bash

export ARCH=arm
export SUBARCH=arm

export CROSS_COMPILE=~/android/toolchains/android-toolchain-eabi-4.7-2013.09/bin/arm-eabi-

make ap33_android_defconfig
make

rm ../out/zImage

rm ../out/flashable/kernel.zip
rm ../out/flashable/kernel/* -rf
rm ../out/flashable/system/lib/modules/* -rf

cp arch/arm/boot/zImage ../out/
find . -name '*ko' -exec cp '{}' ../out/flashable/system/lib/modules/ \;

cd ../out/tools

./mkbootimg --kernel ../zImage --ramdisk ramdisk.cpio.gz --ramdiskaddr 0x0049C4F0  -o ../flashable/kernel/boot.img

cd ../flashable

zip -r kernel.zip kernel META-INF system

