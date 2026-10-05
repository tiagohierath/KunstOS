# KunstOS live ISO: boots straight into the KunstOS desktop as the user "nixos" (no password).
# Build it with: nix build .#nixosConfigurations.kunstos-iso.config.system.build.isoImage
{ lib, ... }:
{
  # The ISO brings its own bootloader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  image.baseName = lib.mkForce "kunstos-live";
  isoImage.volumeID = lib.mkForce "KUNSTOS";

  # Skip the login screen once, straight into niri.
  services.greetd.settings.initial_session = {
    command = "niri-session";
    user = "nixos";
  };
}
