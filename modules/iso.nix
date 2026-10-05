# KunstOS live ISO: boots straight into the KunstOS desktop as the user "nixos" (no password).
# Build it with: nix build .#nixosConfigurations.kunstos-iso.config.system.build.isoImage
{ lib, ... }:
{
  # The ISO brings its own bootloader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  image.baseName = lib.mkForce "kunstos-live";
  isoImage.volumeID = lib.mkForce "KUNSTOS";

  # The minimal ISO profile turns these off; a desktop needs them.
  xdg.icons.enable = true;
  xdg.mime.enable = true;
  xdg.autostart.enable = true;
  services.udisks2.enable = true;
  documentation.man.enable = true; # the manual teaches man

  # Skip the login screen once, straight into niri.
  services.greetd.settings.initial_session = {
    command = "niri-session";
    user = "nixos";
  };
}
