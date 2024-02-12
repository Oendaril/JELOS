# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="retrorun"
PKG_VERSION="41c8d62cd74bd25aeb70cd8304741edead734022"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/navy1978/retrorun"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libdrm libpng linux libevdev openal-soft librga"
PKG_LONGDESC="Retrorun is a frontend loader for emulator cores with minimal performance overhead"
PKG_TOOLCHAIN="make"

pre_configure_target() {
    sed -i 's|libevdev-1.0/||g' ${PKG_BUILD}/src/go2/input.cpp
    PKG_MAKE_OPTS_TARGET+=" -C build/gmake/ config=debug ARCH="" verbose=1"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/retrorun ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_retrorun.sh

  mkdir -p ${INSTALL}/usr/config/${PKG_NAME}
  cp ${PKG_DIR}/config/* ${INSTALL}/usr/config/${PKG_NAME}
}
