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
