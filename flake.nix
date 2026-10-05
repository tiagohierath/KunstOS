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
      ++ nixpkgs.lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;
    };

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
      ];
    };

    # SHELVED 2026-10-05, no ISO at all: kunstos-lite live ISO. Do not build.
    packages.x86_64-linux.iso-lite = self.nixosConfigurations.kunstos-lite-iso.config.system.build.isoImage;

    # The lite layer for a stock NixOS install (its hardware-configuration.nix and bootloader stay).
    # The installer's --lite picks this module.
    nixosModules.kunstos-lite.imports = [
      ./configuration.nix
      ./modules/desktop.nix
      ./modules/apps.nix
      ./modules/fonts.nix
      ./modules/screens.nix
      ./modules/manual.nix
      ./modules/lite.nix
    ];

    nixosConfigurations.kunstos-lite = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ self.nixosModules.kunstos-lite ]
      ++ nixpkgs.lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix
      ++ nixpkgs.lib.optional (builtins.pathExists ./local.nix) ./local.nix;
    };

    # QEMU check: stock-style NixOS + the lite layer (tests/lite-vm.nix).
    nixosConfigurations.kunstos-lite-vmtest = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ self.nixosModules.kunstos-lite ./tests/lite-vm.nix ];
    };

    nixosConfigurations.kunstos-lite-iso = nixpkgs.lib.nixosSystem {
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
        ./modules/lite.nix
        ./modules/iso-lite.nix
        { environment.etc."kunstos/flake".source = self; }
      ];
    };
  };
}
