# KunstOS base system: networking, sound, Bluetooth, unfree software, editor.
# The hardware (disks, bootloader) comes from the installer's hardware-configuration.nix.
{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # UEFI boot with systemd-boot, the easiest default for v1.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Sync files between your own devices, and send files to phones nearby.
  environment.systemPackages = [ pkgs.syncthing pkgs.git pkgs.tealdeer ]; # git + tldr are taught in the manual
  programs.localsend.enable = true; # also opens its port in the firewall

  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";

  # Time zone and language are chosen by the installer.
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  system.stateVersion = "26.05";
}
