#!/bin/sh
ZIP_PATH="$1"
DEVICE="$2"
VERSION_H="$3"

if [ $# != "3" ]; then
    echo "Usage: $0 [zip path base] [device] [path to version.h]"
    exit 1
fi

SRC_PATH="$ZIP_PATH.zip"

if [ ! -f "$VERSION_H" ] || [ ! -f "$SRC_PATH" ]; then
    echo "File not found"
    exit 1
fi


ver_main="$(cat $VERSION_H | grep VERSION_AR)"
ver_main=${ver_main#*define VERSION_AR }
ver_dev=${ver_dev%\"}

out_name="${ZIP_PATH}-$(date +%Y%m%d-%H%M)-v${ver_main}${ver_dev}-UNOFFICIAL-${DEVICE}.zip"
echo "--- Creating $out_name"
cp -a "$ZIP_PATH.zip" "$out_name" || exit 1
cd "$(dirname ${out_name})" && md5sum "$(basename ${out_name})" > "${out_name}.md5sum"
