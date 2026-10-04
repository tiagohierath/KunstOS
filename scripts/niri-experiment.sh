#!/usr/bin/env bash
# Runs the KunstOS niri config in a window, on its own D-Bus session, so it never
# touches the real session. Inside the window, Mod is Alt.
cd "$(dirname "$0")/.." || exit 1
[ -d build/icons/ComixCursors-KunstOS ] || nix shell nixpkgs#xcur2png nixpkgs#xorg.xcursorgen -c \
    python3 cursors/kunst-cursors.py \
    "$(nix build --no-link --print-out-paths nixpkgs#comixcursors.Opaque_White)/share/icons/ComixCursors-Opaque-White" \
    build/icons
XCURSOR_PATH="$PWD/build/icons:$XCURSOR_PATH" exec dbus-run-session niri -c dotfiles/niri/config.kdl
