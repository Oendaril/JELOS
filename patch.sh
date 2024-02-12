#!/usr/bin/bash

make docker-shell

export OS_VERSION=$(date +%Y%m%d) BUILD_DATE=$(date)
export PROJECT=Rockchip DEVICE=RK3326 ARCH=aarch64
./scripts/clean retrorun
./scripts/build retrorun
#./scripts/install retrorun
#./scripts/image mkimage

exit
