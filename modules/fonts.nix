# KunstOS fonts: PxPlus ToshibaSat 9x16 at 12 pt for most things, Recursive for app interfaces.
# Anything those fonts lack (emoji, Braille, box corners, symbols like ✔ ✗ ★, Cyrillic)
# comes from Noto, the next fonts in each list.
{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.ultimate-oldschool-pc-font-pack
    pkgs.recursive
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.departure-mono # installed to pick, not a default
    pkgs.nerd-fonts.symbols-only # the Waybar icons
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "PxPlus ToshibaSat 9x16" "Symbols Nerd Font Mono" "Noto Sans Mono" "Noto Sans Symbols 2" "Noto Color Emoji" ];
    sansSerif = [ "Recursive" "Noto Sans" "Noto Sans Symbols 2" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
