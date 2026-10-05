#!/usr/bin/env bash
# Builds docs/manual/pdf/manual.pdf with the PxPlus ToshibaSat font from nixpkgs.
set -e
cd "$(dirname "$0")"
fonts=$(nix build --no-link --print-out-paths nixpkgs#ultimate-oldschool-pc-font-pack)/share/fonts
nix shell nixpkgs#typst -c typst compile --root ../../.. --font-path "$fonts" manual.typ manual.pdf
