#!/bin/bash

set -e

GENIMAGE_CFG="board/amtech/rpi3_router/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

mkdir -p "${BINARIES_DIR}/autoboot/"
cp board/amtech/rpi3_router/autoboot.txt "${BINARIES_DIR}/autoboot/"
cp board/amtech/rpi3_router/config_autoboot.txt "${BINARIES_DIR}/autoboot/config.txt"

mkdir -p "${BINARIES_DIR}/boot/"
cp board/amtech/rpi3_router/config_boot.txt "${BINARIES_DIR}/boot/config.txt"
cp board/amtech/rpi3_router/cmdline.txt "${BINARIES_DIR}/boot/"

genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
