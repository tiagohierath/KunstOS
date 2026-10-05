# kunstos-lite: KunstOS for old laptops (about 3-4GB RAM, weak or no GPU acceleration).
# Everything else comes from the shared modules; this file only holds the differences.
{ lib, pkgs, ... }:
{
  # Fewer heavy apps: Firefox stays (the manual opens in it), Syncthing and LocalSend go.
  kunstos.funApps = lib.mkForce false;
  programs.localsend.enable = lib.mkForce false;

  # Compressed swap in RAM instead of a swap partition.
  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;

  environment.systemPackages = [ pkgs.btop pkgs.sway ];

  # No GPU acceleration (old Intel or a VM): Mesa falls back to llvmpipe by itself.
  # If niri still fails, "sway (software)" in the login screen draws with the CPU only.
  services.displayManager.sessionPackages = [
    ((pkgs.writeTextDir "share/wayland-sessions/sway-soft.desktop" ''
      [Desktop Entry]
      Name=sway (software)
      Exec=env WLR_RENDERER=pixman WLR_NO_HARDWARE_CURSORS=1 sway --unsupported-gpu
      Type=Application
    '').overrideAttrs { passthru.providedSessions = [ "sway-soft" ]; })
  ];
  environment.etc."sway/config".source = ../dotfiles/sway/config;

  # Keep the bootloader of the stock NixOS install (GRUB on BIOS, systemd-boot on UEFI):
  # configuration.nix turns systemd-boot on only as a default, this takes it back.
  boot.loader.systemd-boot.enable = lib.mkOverride 900 false;
  boot.loader.efi.canTouchEfiVariables = lib.mkOverride 900 false;
}
