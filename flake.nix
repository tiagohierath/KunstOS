# KunstOS system flake. Install it with: nixos-rebuild switch --impure --flake /etc/nixos#kunstos
# (--impure because the apps list is read from /etc/nixos/kunstos-apps.json, see modules/apps.nix)
{
  description = "KunstOS: a NixOS desktop for visual artists";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.kunstos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./modules/desktop.nix
        ./modules/apps.nix
        ./modules/fonts.nix
        ./modules/screens.nix
        ./modules/manual.nix
      ]
      # Disks and drivers, written by the installer next to this file.
      ++ nixpkgs.lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix
      # User, password hash, host name and bootloader, written by kunst-install.
      ++ nixpkgs.lib.optional (builtins.pathExists ./local.nix) ./local.nix;
    };

    # Everything KunstOS adds to a NixOS machine. The install command imports this
    # next to the machine's own configuration.nix.
    nixosModules.default = {
      imports = [
        ./configuration.nix
        ./modules/desktop.nix
        ./modules/apps.nix
        ./modules/fonts.nix
        ./modules/screens.nix
        ./modules/manual.nix
      ];
    };
    # nixosModules.lite: hook for the kunstos-lite variant (install --lite), not defined yet.

    # Turn a stock NixOS into KunstOS:
    #   nix --extra-experimental-features 'nix-command flakes' run github:tiagohierath/KunstOS/v0.1#install
    apps.x86_64-linux.install = {
      type = "app";
      program = "${nixpkgs.legacyPackages.x86_64-linux.writeShellScriptBin "kunstos-install" (builtins.readFile ./scripts/kunstos-install)}/bin/kunstos-install";
    };

    # nix build .#iso (shelved for the launch: no ISO, see TODO.md)
    packages.x86_64-linux.iso = self.nixosConfigurations.kunstos-iso.config.system.build.isoImage;

    # Live ISO: nix build .#nixosConfigurations.kunstos-iso.config.system.build.isoImage
    nixosConfigurations.kunstos-iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./configuration.nix
        ./modules/desktop.nix
        ./modules/apps.nix
        ./modules/fonts.nix
        ./modules/screens.nix
        ./modules/manual.nix
        ./modules/iso.nix
        ./modules/calamares.nix
        ./modules/installer.nix
        # kunst-install copies this flake to the new disk.
        { environment.etc."kunstos/flake".source = self; }
      ];
    };
  };
}
