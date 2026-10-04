# KunstOS

OS for Visual Artists based on NixOS.

Recently I have been learning a lot about the Nix Language, so I wanted to make
a "distro" of sorts, but for visual artists. Enjoy.

It's for people who draw, paint, model in 3D, make pixel art, sound and code,
and who like to open a terminal and change things. It's not for people who only
use a browser.

**0.1 is a preview.** There's no installer or ISO yet. This release has the
desktop, its look, the app list and the manual. The installable system comes
next ([TODO.md](TODO.md)).

## What's in it

| Part | Where |
|---|---|
| niri desktop: windows tile in columns, no animations | `dotfiles/niri` |
| Gruvbox Dark colors, PxPlus ToshibaSat 9x16 pixel font | `dotfiles/kitty`, `modules/fonts.nix` |
| Wallpaper: Ivan Shishkin, *The Forest Clearing* (1896) | `wallpapers` |
| Cursor: ComixCursors, made fully opaque, with smaller hands | `cursors/kunst-cursors.py` |
| Waybar, notifications (mako), app grid (rofi), fastfetch with the K logo | `dotfiles`, `themes/rofi` |
| Login (ReGreet), lock screen (hyprlock), boot settings | `modules/screens.nix`, `dotfiles/hypr`, `dotfiles/regreet` |
| `kunst-apps`: pick apps one by one or in packs | `scripts/kunst-apps`, `packs/packs.json` |
| Manual for people coming from Windows | `docs/manual` |
| Decisions and the look of terminal apps | `docs/decisions.md`, `docs/tui.md` |

## Try parts of it

Clone it to `~/projects/kunstOS`; some paths expect that for now.

```
fastfetch -c ~/projects/kunstOS/dotfiles/fastfetch/config.jsonc
nix shell nixpkgs#gum nixpkgs#jq -c ~/projects/kunstOS/scripts/kunst-apps
```

`kunst-apps` only shows what it would install unless it runs on KunstOS.

On NixOS with niri, `scripts/niri-experiment.sh` opens the KunstOS desktop in
a window, without touching your own config. Inside it, Mod is Alt.

## Credits and licenses

- KunstOS: MIT, see [LICENSE](LICENSE).
- Wallpaper: Ivan Shishkin, *The Forest Clearing* (1896), public domain, from
  [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Shiskin_-_The_Forest_Clearing.jpg).
- Cursor: built from [ComixCursors](https://limitland.de/comixcursors) by Jens
  Luetkens, GPL-3.0. The script takes it from nixpkgs.
- Fonts, installed from nixpkgs: [Ultimate Oldschool PC Font Pack](https://int10h.org/oldschool-pc-fonts/)
  by VileR (CC BY-SA 4.0), Recursive (OFL), Noto (OFL).
- Colors: [Gruvbox](https://github.com/morhetz/gruvbox) by Pavel Pertsev.
