# The apps the user picked with kunst-apps (or kunst-defaults on first boot).
# They are plain package names from nixpkgs, written to /etc/nixos/kunstos-apps.json.
{ lib, pkgs, ... }:
let
  file = "/etc/nixos/kunstos-apps.json";
  names = lib.optionals (builtins.pathExists file) (builtins.fromJSON (builtins.readFile file));
  # kunst-apps and kunst-defaults, with packs.json next to them (they look for ../packs/packs.json).
  kunstTools = pkgs.runCommand "kunst-tools" { } ''
    mkdir -p $out/bin $out/packs
    cp ${../scripts/kunst-apps} $out/bin/kunst-apps
    cp ${../scripts/kunst-defaults} $out/bin/kunst-defaults
    cp ${../packs/packs.json} $out/packs/packs.json
    chmod +x $out/bin/*
  '';
in
{
  environment.systemPackages = [ kunstTools pkgs.gum pkgs.jq ] ++ map (name: lib.getAttrFromPath (lib.splitString "." name) pkgs) names;
}
