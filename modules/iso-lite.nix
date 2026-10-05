# SHELVED 2026-10-05: KunstOS ships no ISO. Kept, not built.
# kunstos-lite live ISO additions (on top of modules/iso.nix). No installer yet: the
# main ISO's installer pieces live on the main branch; unify after merging.
{ lib, ... }:
{
  # No copytoram (not set anywhere): it runs from the USB stick, never fills a 3GB RAM.
  isoImage.makeBiosBootable = true;
  isoImage.makeEfiBootable = true;
  image.baseName = lib.mkOverride 40 "kunstos-lite-live";
  isoImage.volumeID = lib.mkOverride 40 "KUNSTOS_LITE";
  # The live session has no room for the fun pack (it would build into RAM)
  # and no first-login Firefox; mark both first-login steps as done.
  systemd.tmpfiles.rules = [
    "d /home/nixos/.local/state/kunstos 0755 nixos users -"
    "f /home/nixos/.local/state/kunstos/first-login-done 0644 nixos users -"
    "f /home/nixos/.local/state/kunstos/manual-shown 0644 nixos users -"
  ];
}
