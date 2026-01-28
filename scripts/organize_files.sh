#!/usr/bin/env bash
set -euo pipefail

SRC="${1:-.}"
LOG="actions.log"

mkdir -p data/fasta data/images data/texts

echo "Organizing files from $SRC" | tee -a "$LOG"

mv "$SRC"/*.fasta data/fasta/ 2>/dev/null || true
mv "$SRC"/*.txt data/texts/ 2>/dev/null || true
mv "$SRC"/*.png data/images/ 2>/dev/null || true

echo "Done" | tee -a "$LOG"
