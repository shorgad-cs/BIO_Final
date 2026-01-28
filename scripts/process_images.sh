#!/usr/bin/env bash
set -euo pipefail

IMG_DIR="${1:?Missing image dir}"
SIZE="${2:?Missing size}"

if ! command -v magick >/dev/null; then
  sudo apt-get update && sudo apt-get install -y imagemagick
fi

mkdir -p output/processed_images

for img in "$IMG_DIR"/*.png; do
  magick "$img" -resize "$SIZE" "output/processed_images/$(basename "$img")"
done
