# The KunstOS manual PDF (docs/manual/pdf/manual.typ), the canonical tutorial.
# Built here with Typst, installed at /etc/kunstos/manual.pdf, listed in the apps menu. Always opens in Firefox: beginners know a browser.
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
    Exec=firefox /etc/kunstos/manual.pdf
    Icon=help-contents
    EOF
    cat > $out/share/applications/navylilyworks.desktop <<EOF
    [Desktop Entry]
    Type=Application
    Name=navylilyworks
    Comment=Opens navylily.tv
    Exec=firefox https://navylily.tv
    Icon=web-browser
    EOF
    cat > $out/share/applications/mono82.desktop <<EOF
    [Desktop Entry]
    Type=Application
    Name=mono82
    Comment=Minimal FM music sequencer, opens in Firefox
    Exec=firefox https://mono82.netlify.app
    Icon=web-browser
    EOF
  '';
in
{
  environment.systemPackages = [ manual ];
  environment.etc."kunstos/manual.pdf".source = "${manual}/manual.pdf";
}
