#!/usr/bin/env bash
# preview the kunstOS app grid without installing rofi
cd "$(dirname "$0")" && nix run nixpkgs#rofi -- -show drun -show-icons -display-drun "Applications" -drun-display-format "{name}" -theme ./grid.rasi
