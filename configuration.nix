# KunstOS base system: networking, sound, Bluetooth, unfree software, editor.
# The hardware (disks, bootloader) comes from the installer's hardware-configuration.nix.
{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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

  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";

  # Time zone and language are chosen by the installer.
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  system.stateVersion = "26.05";
}
