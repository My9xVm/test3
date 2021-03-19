# shellcheck shell=sh
#
# usage:
#   export ARCH=arm CROSS_COMPILE=armv7l-linux-musleabihf-
#   # export ARCH=x86_64
#   debug=false static=false
#   . **/set_environment_variables.sh
#   unset debug static
#

AR="gcc-ar"
CC="gcc"
RANLIB="gcc-ranlib"
CPPFLAGS=""
CFLAGS=""
CXXFLAGS=""
LDFLAGS=""
SOURCE_DATE_EPOCH=0
export AR CC RANLIB CPPFLAGS CFLAGS CXXFLAGS LDFLAGS SOURCE_DATE_EPOCH


CFLAGS="-pipe" # 3.2 Options Controlling the Kind of Output
if [ "$debug" = "true" ]; then
  CFLAGS="${CFLAGS} -gdwarf-5 -ffile-prefix-map=$(pwd)= -gsplit-dwarf -fdebug-types-section -gz=none" # 3.10 Options for Debugging Your Program
else
  LDFLAGS="-Wl,--build-id=none -s"
fi
CFLAGS="${CFLAGS} -O2 -falign-functions=32 -ffunction-sections" # 3.11 Options That Control Optimization
if [ "$ARCH" = "arm" ]; then
  CFLAGS="${CFLAGS} -mabi=aapcs-linux -mfloat-abi=hard -march=armv7ve -mtune=cortex-a7 -mfpu=neon-vfpv4 -mtls-dialect=gnu2" # 3.19.5 ARM Options
elif [ "$ARCH" = "x86_64" ]; then
  CFLAGS="${CFLAGS} -march=core2 -mtune=core2" # 3.19.59 x86 Options
fi
if [ "$static" = "true" ]; then
  LDFLAGS="${LDFLAGS} -Wl,--gc-sections -static"
else
  CPPFLAGS="-D_FORTIFY_SOURCE=2"
  LDFLAGS="${LDFLAGS} -Wl,-z,now,--gc-sections"
fi
CXXFLAGS="$CFLAGS"

#
# x86 Options
# CFLAGS="${CFLAGS} -mabm -maes -mfsgsbase -mlzcnt -mpclmul -mpopcnt -mrdrnd -msse4.1 -msse4.2 -mmovbe"
#
