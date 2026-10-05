# KunstOS base system: networking, sound, Bluetooth, unfree software, editor.
# The hardware (disks, bootloader) comes from the installer's hardware-configuration.nix.
{ lib, pkgs, ... }:
{
  # Turn whole groups of apps off: change true to false, save, then run
  #   sudo nixos-rebuild switch --impure --flake /etc/nixos#kunstos
  kunstos.coreApps = lib.mkDefault true; # Firefox, Thunar, Syncthing, LocalSend
  kunstos.funApps = lib.mkDefault true; # the fun tinkering pack (Aseprite, Orca, TIC-80...)

  nixpkgs.config.allowUnfree = true;

  # The bootloader is NOT set here: it comes from the machine's own configuration.nix
  # (stock NixOS install + the install command) or from local.nix (kunst-install on the ISO).
  # Old v0.1 line, kept: boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # kunst-apps and kunstos-update use the flake
  system.nixos.extraOSReleaseArgs.KUNSTOS_VERSION = "0.1";

  networking.networkmanager.enable = true;

  # Drivers for any laptop: Wi-Fi/GPU firmware, 3D for every GPU.
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  # Compressed swap in RAM, helps on 4 GB machines.
  zramSwap.enable = true;

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
  # Old line, kept: i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  # (off: it dropped the machine's own language, e.g. pt_BR, on installs from stock NixOS)

  system.stateVersion = lib.mkDefault "26.05"; # the machine's own value wins
}
