# kunstOS TODO

- [ ] Milestone 1: flake that boots a QEMU VM into niri (floating windows), Krita installed
- [x] Terminal color palette from the cross-stitch embroidery DROPPED; default = Gruvbox Dark from his own kitty (dotfiles/kitty)
- [ ] App menu: grid launcher like KDE/Fedora layout (search top, big icons + names); fuzzel cannot grid, prototyping rofi
- [x] fastfetch: KunstOS ASCII logo + config (dotfiles/fastfetch). Logo APPROVED: 13-line serif K, `jp2a --invert --height=13 k-source.jpg`
- [x] fastfetch 2x version: scrapped (too silly), standard config.jsonc is the only one
- [x] fastfetch: K inside a circle, tried and dropped; plain K stays
- [x] Waybar default (approved 2026-10-04): copy of config-niri + dark.css, personal modules swapped for built-ins, square corners, no gray (dotfiles/waybar)
- [ ] Default cursor: ComixCursors-KunstOS (Opaque White, shrunk hand + others, solid zoom lens, grab added; cursors/kunst-cursors.py), live test until 17:28
- [ ] Fonts: use ALL of Recursive's variants (Mono/Sans, Casual/Linear, weights, slant, cursive axes) across the system, not just Recursive Mono
- [x] Default wallpaper: Shishkin, The Forest Clearing (1896), 4316x2880 original from Wikimedia Commons, wallpapers/default.jpg
- [ ] Live test: KunstOS wallpaper on Tiago's desktop (fill mode: never stretch, never black borders)
- [x] Window close animation: TV-off shader tried and dropped; windows close instantly (window-close off)
- [x] Windows open instantly (window-open off, dotfiles/niri/animations.kdl)
