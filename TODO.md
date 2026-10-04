# KunstOS TODO

Decisions are in docs/decisions.md. The TUI look is in docs/tui.md.

## Ship v1, in order

- [ ] 1. System flake (milestone 1): stable NixOS 26.05, unfree allowed, tiled niri, KunstOS defaults installed system-wide (/etc/xdg, /etc/niri), packages, Recursive fonts, ComixCursors-KunstOS, wallpaper, audio, Wi-Fi, Bluetooth, no hardcoded home paths or keyboard layout, apps read from /etc/nixos/kunstos-apps.json. Done when a VM boots into the KunstOS desktop.
- [ ] 2. Boot and login screens (in progress): boot menu, boot splash, login greeter, Gruvbox console colors
- [ ] 3. Lock screen and idle (in progress)
- [ ] 4. kunst-apps rebuilt in Go (Bubble Tea) to the TUI standard: 2x2 pack boxes, details box with the one-sentence description; package Pictogrep from its flake
- [ ] 5. Fonts: Recursive Mono only in the terminal, Recursive Sans everywhere else (Waybar, mako, rofi)
- [ ] 6. Light mode: Gruvbox Light for kitty, Waybar, mako, rofi and the TUIs, plus a way to switch (can slip to v1.1)
- [ ] 7. Live ISO that boots into KunstOS
- [ ] 8. Graphical installer customized for KunstOS (Calamares with KunstOS branding, installs the KunstOS flake); needs an SVG of the K logo
- [ ] 9. Real hardware test from a USB stick: Wi-Fi, suspend and lock, tablet pressure in Krita
- [ ] 10. Release docs: manual and tips for people coming from Windows (shortcuts and the rest); audience is tinkerers, not people who only use a browser
- [ ] 11. Release: README with screenshots, credits and licenses (Shishkin wallpaper, GPL cursor, OFL fonts), ISO and checksum as a GitHub release, push

## Open right now

- [ ] Restore Tiago's own wallpaper when he's done testing (his swaybg was swapped for the KunstOS one; it also comes back on his next login)

## Later

- GTK theme and icons beyond dark by default
- Our Paint (not in nixpkgs; package its v0.5 Linux AppImage, GPL-3.0)
- Website

## Done

- [x] Terminal colors: Gruvbox Dark from Tiago's kitty (dotfiles/kitty)
- [x] fastfetch: 13-line K logo (`jp2a --invert --height=13 k-source.jpg`), title "KunstOS", 10 plain modules (dotfiles/fastfetch)
- [x] Waybar: his config-niri look with built-in modules, square corners (dotfiles/waybar)
- [x] Notifications: mako styled like the fuzzel menu (dotfiles/mako)
- [x] Cursor: ComixCursors-KunstOS, opaque, smaller hand, grab added (cursors/kunst-cursors.py)
- [x] Wallpaper: Shishkin, The Forest Clearing (1896), full resolution, public domain (wallpapers/)
- [x] App menu: rofi grid (themes/rofi/grid.rasi) on Mod+R
- [x] niri config: copy of Tiago's (dotfiles/niri/config.kdl), tested nested with scripts/niri-experiment.sh; no animations, opaque unfocused windows, libinput tablets
- [x] kunst-apps prototype with gum (scripts/kunst-apps) and packs/packs.json with labels and one-sentence descriptions
- [x] TUI standard (docs/tui.md)
- [x] Decisions (docs/decisions.md)

## Dropped

- isabela-eyes palette
- fastfetch 2x version, K in a ring, spaced "k u n s t O S" title
- TV-off close animation and window animations in general
- Sketchbook layout with page turns
- Floating windows by default
- Our Paint, for now
