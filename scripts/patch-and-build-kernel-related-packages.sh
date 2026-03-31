#!/bin/bash

set -e

# nowdir: $PROJECT_ROOT

cd $VYOS_BUILD_ROOT
patch -p1 < $PROJECT_ROOT/patches/vyos-build/0011-build-linux-package-toml.patch
patch -p1 < $PROJECT_ROOT/patches/vyos-build/0012-build-jool.patch
patch -p1 < $PROJECT_ROOT/patches/vyos-build/0013-build-linux-firmware.patch
patch -p1 < $PROJECT_ROOT/patches/vyos-build/0014-build-qat.patch

cd $VYOS_BUILD_ROOT/scripts/package-build/linux-kernel
./build.py --packages linux-firmware ovpn-dco nat-rtsp qat igb ixgbe ixgbevf jool realtek-r8126 realtek-r8152 ipt-netflow # seems that accel-ppp-ng is not required, I have confirmed jool nat-rtsp ovpn-dco must be built. qat igb ixgbe ixgbevf is important for amd64 but 6.17 will failed
ls -la ./*.deb
mv ./*.deb $VYOS_BUILD_ROOT/packages/