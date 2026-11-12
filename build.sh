#!/usr/bin/env bash
set -euo pipefail

EDITION="${1:-standard}"
case "$EDITION" in
  standard|nvidia|minimal) ;;
  *) echo "Unknown edition: $EDITION" >&2; exit 2 ;;
esac

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$ROOT/build/$EDITION"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

lb clean --purge 2>/dev/null || true

rm -rf config
cp -a "$ROOT/config" .
find config/hooks -type f -name '*.hook.chroot' -exec chmod +x {} \; 2>/dev/null || true
find config/includes.chroot -type f -path '*/bin/*' -exec chmod +x {} \; 2>/dev/null || true

cp "$ROOT/config/package-lists/standard.list.chroot" \
   "config/package-lists/00-standard.list.chroot"
if [ "$EDITION" != "standard" ] && [ -f "$ROOT/config/package-lists/${EDITION}.list.chroot" ]; then
  cp "$ROOT/config/package-lists/${EDITION}.list.chroot" \
     "config/package-lists/10-${EDITION}.list.chroot"
fi

lb config \
  --distribution bookworm \
  --debian-installer live \
  --archive-areas "main contrib non-free non-free-firmware" \
  --bootappend-live "boot=live components quiet splash" \
  --binary-images iso-hybrid \
  --iso-application "Gamenux" \
  --iso-volume "GAMENUX_${EDITION^^}" \
  --memtest none \
  --win32-loader false

lb build

ISO=$(ls -1 *.iso 2>/dev/null | head -n1)
if [ -n "$ISO" ]; then
  mkdir -p "$ROOT/build"
  mv "$ISO" "$ROOT/build/gamenux-${EDITION}.iso"
  echo "Built: $ROOT/build/gamenux-${EDITION}.iso"
fi