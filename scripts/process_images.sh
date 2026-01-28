#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/process_images.sh <images_dir> <size>
IMG_DIR="${1:?Missing image directory}"
SIZE="${2:?Missing size (e.g. 300x300)}"

LOG="logs/images.log"
OUT="output/processed_images"

mkdir -p logs "$OUT"

echo "---- $(date) process_images.sh ----" | tee -a "$LOG"
echo "Input dir : $IMG_DIR" | tee -a "$LOG"
echo "Resize to : $SIZE" | tee -a "$LOG"

# Update packages (safe for Codespaces)
sudo apt-get update -y || true

# Install ImageMagick if convert is missing
if ! command -v convert >/dev/null 2>&1; then
  echo "Installing ImageMagick (convert)..." | tee -a "$LOG"
  sudo apt-get install -y imagemagick || {
    echo "ERROR: Failed to install ImageMagick" | tee -a "$LOG"
    exit 1
  }
fi

shopt -s nullglob
count=0

for img in "$IMG_DIR"/*.png "$IMG_DIR"/*.jpg "$IMG_DIR"/*.jpeg; do
  base="$(basename "$img")"
  echo "Processing $base" | tee -a "$LOG"
  convert "$img" -resize "$SIZE" "$OUT/$base"
  count=$((count+1))
done

echo "Completed. $count images processed." | tee -a "$LOG"
