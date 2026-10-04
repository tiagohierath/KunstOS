# KunstOS desktop: niri, the bars and launchers, the file tools, the cursor, and the
# dotfiles installed system-wide under /etc (niri, kitty, waybar, mako, fuzzel, fastfetch, rofi).
# Users can override any of them by copying the file into ~/.config.
{ pkgs, ... }:
let
  # ComixCursors-KunstOS, built from the GPL ComixCursors Opaque White theme.
  # Same steps as cursors/kunst-cursors.py run by hand.
  cursor = pkgs.stdenvNoCC.mkDerivation {
    pname = "comixcursors-kunstos";
    version = "0.1";
    dontUnpack = true;
    nativeBuildInputs = with pkgs; [ python3 imagemagick xcur2png xcursorgen ];
    buildPhase = ''
      mkdir -p $out/share/icons
      python3 ${../cursors/kunst-cursors.py} \
        ${pkgs.comixcursors.Opaque_White}/share/icons/ComixCursors-Opaque-White $out/share/icons
    '';
    dontInstall = true;
  };
in
{
  programs.niri.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    cursor
    kitty
    fuzzel
    rofi
    waybar
    mako
    fastfetch
    yazi
    helix
    swaybg
    udiskie
    cliphist
    wl-clipboard
    brightnessctl
    playerctl
    firefox
    jq
  ];

  # niri reads /etc/niri/config.kdl when the user has no config of their own.
  environment.etc = {
    "niri/config.kdl".source = ../dotfiles/niri/config.kdl;
    "niri/animations.kdl".source = ../dotfiles/niri/animations.kdl;
    "xdg/waybar/config.jsonc".source = ../dotfiles/waybar/config.jsonc;
    "xdg/waybar/style.css".source = ../dotfiles/waybar/style.css;
    "xdg/mako/config".source = ../dotfiles/mako/config;
    "xdg/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;
    "xdg/kitty/current-theme.conf".source = ../dotfiles/kitty/current-theme.conf;
    "xdg/fuzzel/fuzzel.ini".source = ../dotfiles/fuzzel/fuzzel.ini;
    "xdg/fastfetch/config.jsonc".source = ../dotfiles/fastfetch/config.jsonc;
    "kunstos/fastfetch/logo.txt".source = ../dotfiles/fastfetch/logo.txt;
    "kunstos/rofi/grid.rasi".source = ../themes/rofi/grid.rasi;
  };
}
