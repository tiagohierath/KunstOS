// KunstOS manual, printable. Build: docs/manual/pdf/build.sh
#let ink = rgb("#282828")
#let paper = rgb("#fbf1c7")
#let red = rgb("#9d0006")
#let gold = rgb("#b57614")

#set page(paper: "a4", margin: (x: 1.6cm, y: 1.4cm), fill: paper)
#set text(font: "PxPlus ToshibaSat 9x16", size: 12pt, fill: ink, lang: "en")
#set par(leading: 0.5em)
#show heading: it => block(above: 1.1em, below: 0.6em, text(fill: red, size: 12pt, it.body))
#show raw: set text(font: "PxPlus ToshibaSat 9x16", size: 12pt)

#let key(k) = box(stroke: 1pt + ink, inset: (x: 3pt, y: 1pt), outset: (y: 1pt), k)
#let keys(..ks) = ks.pos().map(key).join([+])

#grid(columns: (auto, 1fr), column-gutter: 1.2em, align: horizon,
  text(fill: gold, size: 7pt, raw(read("../../../dotfiles/fastfetch/logo.txt").replace("$1", ""))),
  [
    #text(size: 24pt)[#text(fill: red)[Kunst]#text(fill: gold)[OS]] \
    The first hour
  ],
)

KunstOS is a desktop for making art. Windows never overlap: each one gets its
own column on a strip that scrolls sideways. You drive it with the keyboard.
Super is the key with the Windows logo on it.

= Open and close things

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  keys[Super][R], [Apps menu. Type a name, press Enter.],
  keys[Super][Enter], [Terminal.],
  keys[Super][E], [Files (yazi, in the terminal).],
  keys[Super][Y], [Firefox.],
  keys[Super][Q], [Close the window you're in.],
)

= Move around

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [#keys[Super][H] #keys[Super][L]], [Go to the column on the left or right.],
  [#keys[Super][U] #keys[Super][I]], [Go to the workspace below or above.],
  keys[Super][O], [See every window at once.],
  keys[Super][F], [Make this column fill the screen.],
  [#keys[Super][Shift][F]], [Fullscreen.],
  keys[Super][V], [Let this window float on top.],
  [#keys[Super][Ctrl][H] #keys[Super][Ctrl][L]], [Move this column left or right.],
)

= Other keys

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  keys[Super][Print], [Screenshot.],
  keys[Super][T], [Things you copied earlier.],
  [#keys[Super][Alt][L]], [Lock the screen.],
  [#keys[Super][Shift][E]], [Log out.],
)

#pagebreak()

#text(size: 24pt)[#text(fill: red)[Kunst]#text(fill: gold)[OS]] \
Commands for the terminal

KunstOS is NixOS. The whole system is described by text files in
`/etc/nixos`. You change a file, then rebuild, and the system becomes what
the files say. Commands with `sudo` ask for your password.

= Install apps

A fresh KunstOS comes with the desktop and a pack of fun tools. Everything
else is one command away. Open a terminal and run:

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[`kunst-apps`]

Pick apps with Space, take a whole pack with A, then press Enter. It asks for
your password and installs them. Don't use `nix-env`: KunstOS keeps every app
in its config.

= Rebuild after changing the config

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `sudo nixos-rebuild switch --impure --flake /etc/nixos#kunstos`
]

Edit the config with `sudo hx /etc/nixos/configuration.nix`. If the rebuild
fails, nothing changed: read the error, fix the file, run it again.

= Find and try programs

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  `nix search nixpkgs krita`, [Look for a program by name.],
  `nix run nixpkgs#cowsay`, [Run a program once without installing it.],
  `nix shell nixpkgs#gimp`, [Have it in this terminal until you close it.],
)

= Update

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `sudo nix flake update --flake /etc/nixos` \
  `sudo nixos-rebuild switch --impure --flake /etc/nixos#kunstos`
]

= Go back when something breaks

Every rebuild is kept as a generation. The boot menu lists them: pick an
older one to start the system as it was.

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  `nixos-rebuild list-generations`, [See every generation.],
  `sudo nixos-rebuild switch --rollback`, [Go back one, without rebooting.],
  `sudo nix-collect-garbage -d`, [Delete old generations to free disk space.],
)

#pagebreak()

= You are here

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [niri], [Windows. Places them in columns, moves you between them.],
  [Waybar], [Status. The bar at the top: Wi-Fi, sound, battery, clock.],
  [rofi], [Applications. The menu on #keys[Super][R].],
  [terminal], [Tools. Every program can be driven from here.],
  [Nix], [The system. What's installed and how it's set up.],
  [Git], [History. Every change you saved, and a way back to it.],
)

= How do I find things?

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  `command -v krita`, [Is this command installed, and where?],
  `man ffmpeg`, [The full manual of a command. Q quits.],
  `tldr tar`, [Short examples of a command.],
  `nix search nixpkgs synth`, [Find software to install.],
  `whereis kitty`, [Where a program and its manual live.],
)

Don't remember everything. Learn how to ask the machine.

= Tinker safely

Put your config in Git once, so every change can be seen and undone:

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `cd /etc/nixos && sudo git init && sudo git add -A && sudo git commit -m start`
]

Then, every time you change something:

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  `git status`, [Which files you changed.],
  `git diff`, [What exactly you changed.],
  `nix flake check --impure`, [Does the config still make sense?],
  `sudo nixos-rebuild test --impure --flake .#kunstos`, [Try it now. A reboot undoes it.],
  `sudo git commit -am "what I did"`, [Keep it.],
)

Try things. Keep the working state. Commit interesting changes.

#pagebreak()

= Things you should try

KunstOS is for art, so start with the strange tools. The fun pack is already
installed; the rest are in `kunst-apps`.

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [Orca], [Music from letters on a grid. Run `orca` in a terminal.],
  [Uxn], [A tiny computer that runs the Hundred Rabbits apps.],
  [Pure Data], [Patch boxes together into sound.],
  [TIC-80], [A pretend game console: draw, code and play in one window.],
  [Bonzomatic], [Write shaders live and watch them change.],
  [Krita], [Painting, with your tablet's pressure.],
  [Blender], [3D: model, sculpt, animate, render.],
  [Inkscape], [Vector drawing.],
  [Typst], [Typesetting. This manual is made with it.],
  [FFmpeg], [Cut, convert and glue any video or sound.],
)

= The terminal as an art tool

A terminal is a tiny programmable workshop. Each command does one thing, and
you chain them: `ffmpeg`, `magick`, `curl`, `grep`, `sed`, `awk`, `python`,
`git`. FFmpeg and ImageMagick come with the video and sound pack.

A folder of sketch photos, turned into one PDF:

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `mkdir small` \
  `magick mogrify -path small -resize 1600x *.jpg` \
  `cd small && magick mogrify -gravity center -crop 1600x1200+0+0 *.jpg` \
  `n=1; for f in *.jpg; do mv "$f" page-$n.jpg; n=$((n+1)); done` \
  `magick page-*.jpg sketchbook.pdf`
]

Resize, crop, rename, PDF. Change one line and you have a different tool.

= If you break it

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  Congratulations. You are now using NixOS.

  Restart. In the boot menu, pick an older generation. Boot. Look at what you
  changed in `/etc/nixos` (`git diff`). Fix it. Rebuild.
]

#pagebreak()

= Wi-Fi, sound and Bluetooth

The bar at the top shows them. Set them up from a terminal:

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  `nmtui`, [Wi-Fi. Pick "Activate a connection", choose a network, type the password.],
  [click the volume], [Mute or unmute. Scroll on it to change the volume.],
  `wpctl status`, [List speakers and microphones, with their numbers.],
  `wpctl set-default 42`, [Make number 42 the one you hear.],
  `bluetoothctl`, [Bluetooth. Then type `scan on`, `pair` and the address, `connect` and the address.],
)

Without Wi-Fi nothing else works, `kunst-apps` included. Do this first.

= Drawing tablet

Plug it in. Wacom, Huion and XP-Pen tablets work without drivers. To check
pressure, open Krita, pick a brush and draw a line pressing light, then hard:
the line should go from thin to thick. If it doesn't, look in Settings,
Configure Krita, Tablet settings.

With more than one screen, tie the tablet to one of them. Find the screen's
name with `niri msg outputs`, then add this to `~/.config/niri/config.kdl`:

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `input { tablet { map-to-output "eDP-1"; } }`
]

= Files and USB drives

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [Thunar], [Files with a mouse, in the apps menu.],
  [yazi], [Files with the keyboard, #keys[Super][E]. Arrows move, Enter opens, Q quits.],
  [USB drives], [Mount by themselves in `/run/media/` + your user name.],
  [Screenshots], [Go to `~/Pictures/Screenshots`.],
)

= Changing the look

Every KunstOS setting is a text file in `/etc/xdg` (and niri's in
`/etc/niri`). To change one, copy it to your home and edit the copy. Yours
wins over the system's:

#block(stroke: 1pt + ink, inset: 8pt, width: 100%)[
  `mkdir -p ~/.config/waybar` \
  `cp /etc/xdg/waybar/* ~/.config/waybar/` \
  `hx ~/.config/waybar/style.css`
]

Wallpaper: in `~/.config/niri/config.kdl`, change the `swaybg` line to your
own picture, then log out and back in.

#pagebreak()

= When something breaks

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [A window froze], [#keys[Super][Q] closes it.],
  [The desktop froze], [#keys[Ctrl][Alt][F2] gives a text login. Log in, run `sudo reboot`.],
  [It won't boot], [In the boot menu, pick an older generation.],
  [Ask for help], [`github.com/tiagohierath/KunstOS/issues`],
)

= Where to go next

#table(columns: (auto, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), column-gutter: 1.2em,
  [Day 1], [Learn niri: the keys on page 1.],
  [Week 1], [Learn the shell: `cd`, `ls`, pipes, `tldr`.],
  [Week 2], [Edit your config and rebuild.],
  [Eventually], [Write your own little tool.],
)

KunstOS is not something to master. It is something to tinker with.
