#!/bin/bash

. /etc/profile

echo 'Starting retrorun'

CORE=$1
GAME=$2
PLATFORM=$3
CONFIGDIR="/storage/.config/retrorun/"
CONFIG="/storage/.config/retrorun/retrorun.cfg"
JOYSTICK="/dev/input/by-path/platform-xbox360-joypad-event-joystick"

if [ ! -f ${CONFIG} ]; then
  if [ ! -d ${CONFIGDIR} ]; then
    mkdir "${CONFIGDIR}"
  fi
  cp -f /usr/config/retrorun/retrorun.cfg "${CONFIGDIR}"
fi

rm  "${JOYSTICK}" || true
echo 'starting gptokeyb in xbox360 mode'
/usr/bin/gptokeyb retrorun xbox360 &

ln -s /dev/input/event4 "${JOYSTICK}"

echo 'using core:' "${CORE}"
echo 'platform:' "${PLATFORM}"
echo 'starting game:' "${GAME}"

EMU="/usr/lib/libretro/${CORE}_libretro.so"
/usr/bin/retrorun -s /storage/roms/"${PLATFORM}" -d /storage/roms/bios "${EMU}" "${GAME}"

rm "${JOYSTICK}"
killall gptokeyb &

echo 'done running retrorun'
