# The apps the user picked with kunst-apps (or kunst-defaults on first boot).
# They are plain package names from nixpkgs, written to /etc/nixos/kunstos-apps.json.
{ lib, pkgs, ... }:
let
  file = "/etc/nixos/kunstos-apps.json";
  names = lib.optionals (builtins.pathExists file) (builtins.fromJSON (builtins.readFile file));
in
{
  environment.systemPackages = map (name: pkgs.${name}) names;
}
