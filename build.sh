#!/bin/bash -x
CYANOGENMOD=../../..
TOOLCHAIN=/home/ivan/kernel_i9003_oc/toolchain
# Make mrproper
make mrproper

#Patch toolchain

export CROSS_COMPILE=$TOOLCHAIN/arm-eabi-4.4.3/bin/arm-eabi-

# Set config
make latona_galaxyslold_defconfig

#Set version

echo "1" > $HOME/kernel_i9003_cm/.version

# Make modules
nice -n 10 make -j8 modules

# Copy modules
find -name '*.ko' -exec cp -av {} $CYANOGENMOD/device/samsung/galaxysl/modules/ \;
find -name '*.ko' -exec cp -av {} $HOME/tmp/modules/ \;
# Build kernel
nice -n 10 make -j8 zImage

# Copy kernel
cp arch/arm/boot/zImage $CYANOGENMOD/device/samsung/galaxysl/kernel
cp arch/arm/boot/zImage $HOME/tmp
# Make mrproper
make mrproper

