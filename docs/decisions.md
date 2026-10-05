# KunstOS decisions

> **Done, 2026-10-04:** the fun tinkering pack now installs on the first login, not during the install (niri runs `kunst-defaults` once, in a kitty window, then marks the login as done in `~/.local/state/kunstos/`).
>
> **Priority, 2026-10-04:** the system needs to be installed as fast as possible. Period. All other tools get installed later, not during the install. This overrides the default-install rows below: nothing except the system itself goes into the install.

**Main goals (2026-10-05):** make people tinker, and make people produce art. Every decision should push toward one of these.

Made by Tiago on 2026-10-04.

| Topic | Decision |
|---|---|
| Name | Spelled **KunstOS**. |
| Languages | English only for now. Portuguese (Brazil) is parked until further notice. |
| Windows | Tiled, normal niri. No title bars. |
| How people get it | A downloadable ISO first. A flake for people already on NixOS later, from the same config. |
| First boot | Only the desktop is installed. The fun tinkering pack installs by default (scripts/kunst-defaults); serious tools (Krita, Blender...) are too heavy for the default and come from kunst-apps. The ISO stays small: default apps download during the install. |
| Installer | Calamares with the KunstOS look: colors, logo and wording. |
| Files and editing | yazi in the terminal, a small graphical file manager (Thunar) for dragging pictures into apps, Helix as the text editor. |
| Installing apps | Always declarative: the system config changes and the system is rebuilt. Never `nix-env` or `nix profile`. |
| Unfree software | Allowed. Aseprite and VCV Rack are in the default fun pack, on purpose. |
| Hardware | Whatever is easiest for v1: NixOS defaults for GPUs, libinput for tablets. |
| Updates | Stable NixOS releases. |
| Fonts | PxPlus ToshibaSat 9x16 at 12 pt for most things (terminal, Waybar, notifications, menus, login, lock). The whole Ultimate Oldschool PC Font Pack is installed. Recursive for app interfaces. Missing glyphs fall back to Noto (Recursive has none of the symbols Toshiba lacks). |
| Light mode | Yes, with Gruvbox Light. Super+Shift+I switches between dark and light. |
| App launcher | The rofi grid (search on top, big icons with names). |
| Animations | None for now. |
| Interfaces | TUI wherever it's possible. |
| Boot | Plain text boot in Gruvbox console colors; boot menu entries named KunstOS. |
| Login screen | Graphical: ReGreet, the wallpaper painting behind a square Gruvbox login box (an exception to TUI-first). |
| Lock screen | hyprlock: the painting, a big clock, the date and a square password box. |
| Unfocused windows | Fully opaque, never see-through. |

## Manual PDF is canonical (2026-10-05)

The tutorial PDF, docs/manual/pdf/manual.typ, is THE KunstOS manual: page 1 the most important keys, page 2 the most important NixOS commands. PxPlus ToshibaSat 12 pt, English first. modules/manual.nix builds it into every install at /etc/kunstos/manual.pdf, with a "KunstOS Manual" entry in the apps menu (always opens in Firefox, also on the first login; beginners won't know zathura). Change the keys or commands in the system, change this file too.

## ISO builds: no limit (2026-10-05)

The once-a-week limit was dropped. Build the ISO when needed.

## More decisions (2026-10-05)

| Topic | Decision |
|---|---|
| Pictogrep and Tiago's software | Added as read-only flake inputs and packaged in KunstOS. They ship in one opt-in "navylilyworks" pack in kunst-apps (Pictogrep, Wortkarten, the rest later), not in the base system. |
| Disk | The installer defaults to ext4, no encryption. Encryption stays a checkbox. No btrfs; NixOS generations already give system rollback. |
| Light mode | Slips to v1.1. v1 ships dark only. |
| Installer (re-checked) | Keep Calamares. NixOS already ships it working; we only rebrand colors, logo and wording. No own TUI installer. |
| No GNOME | Avoid anything GNOME (apps, games, libraries pulled in by choice). Mahjong stays, as KDE's KMahjongg instead of gnome-mahjongg. |
| Calamares branding | modules/calamares.nix copies the stock NixOS branding to "kunstos" and changes only names, Gruvbox sidebar colors and the K logo. Never patch the install modules or their configs. |
