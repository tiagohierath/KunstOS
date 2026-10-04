# Coming from Windows

KunstOS works differently from Windows in a few places. This chapter covers
the ones you'll run into in the first hour.

## Where things are

| On Windows | On KunstOS |
|---|---|
| Start menu | The apps menu: Super+R |
| File Explorer | Thunar, in the apps menu, or yazi, a file manager in the terminal: Super+E |
| Task View | The overview: Super+O |
| Snipping Tool | Super+Print |
| Installers, Microsoft Store | `kunst-apps` and your system config, see below |
| Control Panel, Settings | Text files, see below |
| System Restore | Generations, see below |
| `C:\Users\you` | `/home/you`, also written `~` |
| A USB drive as `D:` | `/run/media/you/` followed by the drive's name |

## Windows don't overlap

Every new window gets its own column on a strip that scrolls sideways, so
nothing hides behind anything else. Super+H and Super+L move between columns,
Super+O shows everything at once. If you want one window floating on top,
press Super+V on it. The full list is in [Shortcuts](shortcuts.md).

## Installing apps

There are no installers to download. A fresh KunstOS has only the desktop, and
`kunst-apps` opens by itself on your first login. To open it again later, open
a terminal (Super+Enter) and run:

```
kunst-apps
```

It lists the apps that come with KunstOS, grouped in packs such as serious art
tools and fun tinkering tools. Pick apps one by one with Space, or press A to
take a whole pack, then Enter. It asks for your password and rebuilds the
system with the apps you picked. The first time takes a few minutes, because
it downloads them.

Anything else comes from nixpkgs, which has over 100,000 packages. Find the
name on [search.nixos.org](https://search.nixos.org/packages), add it to your
system config and rebuild.
<!-- check at release: config file path and rebuild command once the flake exists -->

KunstOS keeps every installed program in its config. Don't use `nix-env` or
`nix profile install`: they install outside the config, and the next rebuild
won't know about them.

To try a program once without installing it:

```
nix run nixpkgs#name
```

## Updates and going back

Nothing changes on your system until you rebuild it. Every rebuild creates a
new generation, and the old ones stay. If an update breaks something, restart
and pick an older generation in the boot menu. The system starts exactly as
it was then. Without restarting:

```
sudo nixos-rebuild switch --rollback
```
<!-- check at release: the update command once the flake exists -->

## Settings are text files

KunstOS keeps its defaults in `/etc/xdg/` (one folder per app) and in
`/etc/niri/config.kdl` for windows and shortcuts. To change something, copy
the file to the same place under `~/.config/` and edit your copy. Delete your
copy to go back to the KunstOS default.

niri, which runs the windows and shortcuts, applies its config the moment you
save the file.

## Files and drives

Your files live in your home folder, `/home/you`. There are no drive letters:
a USB drive mounts by itself under `/run/media/you/` when you plug it in, and
a notification tells you where. Files and folders whose names start with a dot
are hidden. That's where most apps keep their settings.

In yazi (Super+E):

| Key | What it does |
|---|---|
| Arrows or h, j, k, l | Move around |
| Enter or l | Open |
| h | Go up one folder |
| Space | Select |
| y, x, p | Copy, cut, paste |
| d | Move to the trash |
| D | Delete for good |
| r | Rename |
| a | New file. End the name with `/` to make a folder |
| . | Show hidden files |
| q | Quit |

## Windows programs

`.exe` files don't run on KunstOS. Look for the Linux version of the program,
or for an open source one that does the same job on
[search.nixos.org](https://search.nixos.org/packages).

## Turning off

Super+Shift+E logs out. From a terminal:

| Command | What it does |
|---|---|
| `systemctl poweroff` | Turns the computer off |
| `systemctl reboot` | Restarts |
| `systemctl suspend` | Sleeps |
<!-- check at release: a power menu may replace this -->
