# KunstOS decisions

Made by Tiago on 2026-10-04.

| Topic | Decision |
|---|---|
| Name | Spelled **KunstOS**. |
| Windows | Tiled, normal niri. No title bars. |
| How people get it | A downloadable ISO first. A flake for people already on NixOS later, from the same config. |
| Installer | Graphical, customized for KunstOS. |
| Installing apps | Always declarative: the system config changes and the system is rebuilt. Never `nix-env` or `nix profile`. |
| Unfree software | Allowed (Aseprite, Obsidian, NVIDIA drivers). |
| Hardware | Whatever is easiest for v1: NixOS defaults for GPUs, libinput for tablets. |
| Updates | Stable NixOS releases. |
| Fonts | Recursive Mono only in the terminal; Recursive Sans everywhere else. |
| Light mode | Yes, with Gruvbox Light. |
| App launcher | The rofi grid (search on top, big icons with names). |
| Animations | None for now. |
| Interfaces | TUI wherever it's possible. |
| Boot | Plain text boot in Gruvbox console colors; boot menu entries named KunstOS. |
| Login screen | Graphical: ReGreet, the wallpaper painting behind a square Gruvbox login box (an exception to TUI-first). |
| Lock screen | hyprlock: the painting, a big clock, the date and a square password box. |
| Unfocused windows | Fully opaque, never see-through. |
