# KunstOS fonts: PxPlus ToshibaSat 9x16 at 12 pt for most things, Recursive for app interfaces.
# The pixel font has 780 glyphs; anything it lacks (emoji, icons, Braille, some symbols)
# comes from the next font in each list.
{ pkgs, ... }:
{
  fonts.enableDefaultPackages = true; # DejaVu and Noto Color Emoji, used as fallbacks
  fonts.packages = [
    pkgs.ultimate-oldschool-pc-font-pack
    pkgs.recursive
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "PxPlus ToshibaSat 9x16" "DejaVu Sans Mono" "Noto Color Emoji" ];
    sansSerif = [ "Recursive" "DejaVu Sans" "Noto Color Emoji" ];
  };
}
