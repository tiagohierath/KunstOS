# Calamares installer with the KunstOS look.
# Rebranded as safely as possible: the stock NixOS branding folder is copied to "kunstos" and only
# its names, colors and logo change. The install steps, modules and their configs stay NixOS's own.
{ pkgs, ... }:
let
  calamares-kunstos-extensions = pkgs.calamares-nixos-extensions.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      b=$out/share/calamares/branding
      cp -r $b/nixos $b/kunstos
      chmod -R u+w $b/kunstos
      cp ${../dotfiles/fastfetch/k-source.jpg} $b/kunstos/kunstos-logo.jpg
      sed -i \
        -e 's/^componentName: .*/componentName:  kunstos/' \
        -e 's/^\( *shortProductName: *\).*/\1KunstOS/' \
        -e 's/^\( *versionedName: *\).*/\1KunstOS/' \
        -e 's/^\( *shortVersionedName: *\).*/\1KunstOS/' \
        -e 's/^\( *bootloaderEntryName: *\).*/\1KunstOS/' \
        -e 's/^\( *productIcon: *\).*/\1"kunstos-logo.jpg"/' \
        -e 's/^\( *productLogo: *\).*/\1"kunstos-logo.jpg"/' \
        -e 's/^\( *productWelcome: *\).*/\1"kunstos-logo.jpg"/' \
        -e 's/^\( *SidebarBackground: *\).*/\1"#282828"/' \
        -e 's/^\( *SidebarText: *\).*/\1"#EBDBB2"/' \
        -e 's/^\( *SidebarTextCurrent: *\).*/\1"#282828"/' \
        -e 's/^\( *SidebarBackgroundCurrent: *\).*/\1"#D79921"/' \
        $b/kunstos/branding.desc
      substituteInPlace $out/etc/calamares/settings.conf --replace-fail "branding: nixos" "branding: kunstos"
    '';
  });
  calamares-kunstos = pkgs.calamares-nixos.override { calamares-nixos-extensions = calamares-kunstos-extensions; };
in
{
  # Same as nixpkgs' installation-cd-graphical-calamares.nix, with the KunstOS packages.
  programs.partition-manager.enable = true; # kpmcore needs it
  environment.systemPackages = [
    calamares-kunstos
    (pkgs.makeAutostartItem { name = "calamares"; package = calamares-kunstos; })
    calamares-kunstos-extensions
    pkgs.glibcLocales
  ];
  i18n.supportedLocales = [ "all" ];
}
