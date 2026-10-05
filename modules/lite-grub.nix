# SHELVED 2026-10-05, not imported anywhere: kunstos-lite owning its bootloader (BIOS + UEFI GRUB).
# Superseded when lite became a layer over a stock NixOS install that keeps its own bootloader.
{ lib, ... }:
{
  # Boots on legacy BIOS too: GRUB on the disk set by the installer (boot.loader.grub.device).
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.grub = {
    enable = lib.mkDefault true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
}
