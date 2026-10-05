# SHELVED 2026-10-05: no VM testing (Tiago tests on real hardware). Kept, never run.
# QEMU check for kunstos-lite: a stock-style NixOS (GRUB on legacy BIOS, its own user)
# with the lite module on top. Boots through the real bootloader, no 3D acceleration.
# Build: nix build .#nixosConfigurations.kunstos-lite-vmtest.config.system.build.vmWithBootLoader
{ lib, pkgs, modulesPath, ... }:
{
  imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

  # What a stock install's configuration.nix would say.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  users.users.tiago = { isNormalUser = true; password = "test"; extraGroups = [ "wheel" ]; };
  system.stateVersion = "26.05";

  virtualisation.useBootLoader = true;
  virtualisation.memorySize = lib.mkDefault 4096;
  virtualisation.graphics = true;
  virtualisation.qemu.options = [ "-vga std" "-serial file:serial.log" ];
  virtualisation.qemu.virtioKeyboard = true;

  # Log straight into the desktop, then write the RAM use to the serial log once it settles.
  services.greetd.settings.initial_session = { command = "niri-session"; user = "tiago"; };
  systemd.services.lite-report = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.procps pkgs.systemd pkgs.gawk ];
    serviceConfig.Type = "oneshot";
    script = ''
      for i in $(seq 120); do pgrep -x waybar >/dev/null && break; sleep 1; done
      sleep 60
      { echo "== lite-report"; systemd-analyze || true; free -m; zramctl || true
        echo "procs:"; pgrep -a 'niri|sway|waybar|mako' || true
        journalctl -b --no-pager | grep -i -E 'niri.*(render|egl|gbm|error)|llvmpipe|pixman' | tail -20
        echo "== end"; } > /dev/ttyS0 2>&1
    '';
  };
}
