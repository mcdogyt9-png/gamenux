#!/usr/bin/env bash
# gamenux-proton-ge: download & install latest Proton-GE into Steam's compat tools
set -euo pipefail

STEAM_ROOT="${STEAM_ROOT:-$HOME/.steam/root}"
COMPAT="$STEAM_ROOT/compatibilitytools.d"
mkdir -p "$COMPAT"

echo "Fetching latest Proton-GE release..."
TAG=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
      | grep -o '"tag_name": *"[^"]*"' | head -1 | cut -d'"' -f4)
if [ -z "$TAG" ]; then
  echo "Could not determine latest release." >&2; exit 1
fi

ARCHIVE="proton-ge-${TAG}.tar.gz"
URL="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${TAG}/${ARCHIVE}"

cd /tmp
echo "Downloading $URL ..."
curl -L -o "$ARCHIVE" "$URL"
echo "Extracting into $COMPAT ..."
tar -xf "$ARCHIVE" -C "$COMPAT"
rm -f "$ARCHIVE"

echo "Installed Proton-GE ${TAG}. Restart Steam to see it."