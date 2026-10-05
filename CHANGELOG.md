# Changelog

## 0.1 (2026-10-05)

- Install on top of a stock NixOS with one command: `nix --extra-experimental-features 'nix-command flakes' run github:tiagohierath/KunstOS/v0.1#install`. Keeps your configuration.nix, hardware-configuration.nix, bootloader and user; backs up /etc/nixos first.
- `kunstos-update`: newest NixOS 26.05 packages, then rebuild.
- Firmware for common Wi-Fi and GPUs, zram swap, btop in the fun pack.
- KunstOS 0.1 shows in /etc/os-release (NAME=KunstOS, KUNSTOS_VERSION=0.1).
- The live ISO is shelved for now (code kept in modules/iso.nix, modules/installer.nix, scripts/kunst-install).
