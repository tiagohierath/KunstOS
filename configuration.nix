# KunstOS base system: networking, sound, Bluetooth, unfree software, editor.
# The hardware (disks, bootloader) comes from the installer's hardware-configuration.nix.
{ lib, pkgs, ... }:
{
  # Turn whole groups of apps off: change true to false, save, then run
  #   sudo nixos-rebuild switch --impure --flake /etc/nixos#kunstos
  kunstos.coreApps = true; # Firefox, Thunar, Syncthing, LocalSend
  kunstos.funApps = true;  # the fun tinkering pack (Aseprite, Orca, TIC-80...)

  nixpkgs.config.allowUnfree = true;

  # UEFI boot with systemd-boot, the easiest default for v1.
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  networking.networkmanager.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true; # provides wpctl, used by the volume keys
  };

  hardware.bluetooth.enable = true;
  services.udisks2.enable = true; # udiskie mounts USB drives through it

  # Tablets work through libinput, no OpenTabletDriver.
  services.libinput.enable = true;

  environment.systemPackages = [ pkgs.git pkgs.tealdeer ]; # git + tldr are taught in the manual

  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";

  # Time zone and language are chosen by the installer.
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  system.stateVersion = lib.mkDefault "26.05";
}
