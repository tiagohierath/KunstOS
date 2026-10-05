# The apps the user picked with kunst-apps (or kunst-defaults on first boot).
# They are plain package names from nixpkgs, written to /etc/nixos/kunstos-apps.json.
{ config, lib, pkgs, ... }:
let
  file = "/etc/nixos/kunstos-apps.json";
  picked = lib.optionals (builtins.pathExists file) (builtins.fromJSON (builtins.readFile file));
  funPkgs = map (a: a.pkg) (lib.findFirst (p: p.title == "fun tinkering tools") { apps = [ ]; } (lib.importJSON ../packs/packs.json)).apps;
  names = if config.kunstos.funApps then picked else lib.subtractLists funPkgs picked;
  # kunst-apps and kunst-defaults, with packs.json next to them (they look for ../packs/packs.json).
  kunstTools = pkgs.runCommand "kunst-tools" { } ''
    mkdir -p $out/bin $out/packs
    cp ${../scripts/kunst-apps} $out/bin/kunst-apps
    cp ${../scripts/kunst-defaults} $out/bin/kunst-defaults
    cp ${../scripts/kunstos-update} $out/bin/kunstos-update
    cp ${../packs/packs.json} $out/packs/packs.json
    chmod +x $out/bin/*
  '';
in
{
  # Switches set in /etc/nixos/configuration.nix.
  options.kunstos = {
    coreApps = lib.mkOption { type = lib.types.bool; default = true; description = "Firefox, Thunar, Syncthing and LocalSend."; };
    funApps = lib.mkOption { type = lib.types.bool; default = true; description = "The fun tinkering pack, even if picked in kunst-apps."; };
  };

  config.programs.thunar.enable = config.kunstos.coreApps;
  config.programs.localsend.enable = config.kunstos.coreApps; # also opens its port in the firewall
  config.environment.systemPackages = lib.optionals config.kunstos.coreApps [ pkgs.firefox pkgs.syncthing ] ++ [ kunstTools pkgs.gum pkgs.jq ] ++ map (name: lib.getAttrFromPath (lib.splitString "." name) pkgs) names;
}
