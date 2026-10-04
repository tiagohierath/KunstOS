# KunstOS boot, login and lock screens
{ lib, ... }:
{
  # Boot: plain text in Gruvbox colors, boot menu entries named KunstOS.
  system.nixos.distroName = "KunstOS";
  # Tiago's kitty palette; color 7 is cream instead of gray so boot text stays readable.
  console.colors = [
    "282828" "cc241d" "98971a" "d79921" "458588" "b16286" "689d6a" "ebdbb2"
    "928374" "fb4934" "b8bb26" "fabd2f" "83a598" "d3869b" "8ec07c" "ebdbb2"
  ];

  environment.etc."kunstos/wallpaper.jpg".source = ../wallpapers/default.jpg;

  # Login: ReGreet, the painting behind a square Gruvbox box.
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/kunstos/wallpaper.jpg";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
        font_name = lib.mkForce "PxPlus ToshibaSat 9x16 12";
      };
    };
    extraCss = ../dotfiles/regreet/regreet.css;
  };
  services.accounts-daemon.enable = true; # ReGreet reads the user list from it

  # Lock: hyprlock, after 10 idle minutes and before sleep (hypridle).
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  environment.etc."xdg/hypr/hyprlock.conf".source = ../dotfiles/hypr/hyprlock.conf;
  environment.etc."xdg/hypr/hypridle.conf".source = ../dotfiles/hypr/hypridle.conf;
}
