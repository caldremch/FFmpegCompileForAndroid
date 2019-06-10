#!/bin/bash
NDK=/Users/caldremch/work/Tools/NDK/android-ndk-r14b

build_one(){
  echo "开始编译"
./configure \
--prefix=$PREFIX \
--disable-static \
--enable-shared \
--enable-cross-compile \
--disable-runtime-cpudetect \
--disable-asm \
--arch=$ARCH \
--target-os=android \
--cross-prefix=$CROSS_COMPILE \
--disable-stripping \
--sysroot=$PLATFORM \
--enable-muxers \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=aac_latm \
--enable-decoder=h264 \
--enable-decoder=mpeg4 \
--enable-decoder=mjpeg \
--enable-decoder=png \
--disable-encoders \
--enable-encoder=mjpeg \
--enable-encoder=png \
--disable-demuxers \
--enable-demuxer=image2 \
--enable-demuxer=h264 \
--enable-demuxer=aac \
--enable-demuxer=avi \
--enable-demuxer=mpc \
--enable-demuxer=mov \
--enable-demuxer=mpegts \
--disable-parsers \
--enable-parser=aac \
--enable-parser=ac3 \
--enable-parser=h264 \
--disable-debug \
--disable-programs \
--disable-htmlpages \
--disable-manpages \
--disable-podpages \
--disable-txtpages \
--disable-doc \
--disable-symver \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-avdevice \
--enable-avfilter \
--enable-small \
--enable-protocols \
--extra-cflags="$FF_CFLAGS $FF_EXTRA_CFLAGS" \

make clean
make -j16
make install
}

#arm
export TMPDIR=./ffmpegtemp
ARCH=arm
CPU=armv7-a
PREFIX=./android/$CPU
# 编译针对的平台，可以根据自己的需求进行设置
# 这里选择最低支持android-14, arm架构，生成的so库是放在
# libs/armeabi文件夹下的，若针对x86架构，要选择arch-x86
PLATFORM=$NDK/platforms/android-14/arch-$ARCH
# 工具链的路径，根据编译的平台不同而不同
# arm-linux-androideabi-4.9与上面设置的PLATFORM对应，4.9为工具的版本号，
# 根据自己安装的NDK版本来确定，一般使用最新的版本
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi- 
FF_EXTRA_CFLAGS="-march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb"
FF_CFLAGS="-O3 -Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID"
build_one

#x86
ARCH=x86
CPU=x86
PREFIX=./android/$CPU
PLATFORM=$NDK/platforms/android-14/arch-$CPU
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/i686-linux-android- 
FF_EXTRA_CFLAGS="-O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8 "
FF_CFLAGS="-O3 -Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID  "
build_one






