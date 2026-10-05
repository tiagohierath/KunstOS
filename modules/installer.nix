# kunst-install on the live ISO: a plain terminal installer, next to Calamares.
{ pkgs, ... }:
let
  kunst-install = pkgs.writeShellApplication {
    name = "kunst-install";
    runtimeInputs = with pkgs; [ util-linux parted dosfstools e2fsprogs mkpasswd nixos-install-tools coreutils ];
    text = builtins.readFile ../scripts/kunst-install;
    checkPhase = "";
  };
in
{
  environment.systemPackages = [ kunst-install ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
