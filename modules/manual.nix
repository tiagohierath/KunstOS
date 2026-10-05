# The KunstOS manual PDF (docs/manual/pdf/manual.typ), the canonical tutorial.
# Built here with Typst, installed at /etc/kunstos/manual.pdf, listed in the apps menu.
{ pkgs, ... }:
let
  manual = pkgs.runCommand "kunstos-manual" { nativeBuildInputs = [ pkgs.typst ]; } ''
    mkdir -p src/docs/manual/pdf src/dotfiles/fastfetch $out/share/applications
    cp ${../docs/manual/pdf/manual.typ} src/docs/manual/pdf/manual.typ
    cp ${../dotfiles/fastfetch/logo.txt} src/dotfiles/fastfetch/logo.txt
    typst compile --root src --font-path ${pkgs.ultimate-oldschool-pc-font-pack}/share/fonts \
      src/docs/manual/pdf/manual.typ $out/manual.pdf
    cat > $out/share/applications/kunstos-manual.desktop <<EOF
    [Desktop Entry]
    Type=Application
    Name=KunstOS Manual
    Comment=Keys and commands for KunstOS
    Exec=zathura /etc/kunstos/manual.pdf
    Icon=help-contents
    EOF
  '';
in
{
  environment.systemPackages = [ manual pkgs.zathura ];
  environment.etc."kunstos/manual.pdf".source = "${manual}/manual.pdf";
}
