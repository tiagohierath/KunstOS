# KunstOS TUI standard

Every KunstOS terminal app follows this, so they all look like one family.

## Colors

Gruvbox Dark, the same as the terminal theme. The background is the
terminal's own (`#282828`); a TUI never paints it.

| Use | Color |
|---|---|
| text | `#ebdbb2` |
| focus, cursor, key names, "KunstOS" in the header | yellow `#fabd2f` |
| checked, done | green `#b8bb26` |
| borders of boxes without focus | blue `#83a598` |
| errors, removing things | red `#fb4934` |
| cursor row background | `#3c3836` |

Never gray or dimmed text. Separate things with weight (bold or normal) or
with one of the colors above.

## Shapes

- Square box drawing only: `┌─┐│└┘`. Never rounded corners.
- Related items go in a box. The box title sits in the top border, and a
  count sits at the right of the top border.
- The box with focus has a yellow border, the others blue.

## Layout

- Header line: "KunstOS" in yellow bold plus the app name in bold; plain
  status on the right ("2 of 17 installed").
- Body: boxes in a grid, 2 per row at 80 columns or more, 1 per row below.
- Footer: key hints, key in yellow bold, action in normal text, 3 spaces
  between pairs.
- 2 columns of margin on the left; one blank line between header, body and
  footer.
- Everything must fit 80x24.

## Rows

- Cursor row: yellow `▌` at the left edge and a `#3c3836` background.
- Checkbox: `[x]` green bold when on, `[ ]` in text color when off.
- Name in bold, then a plain label of what it is, 1 to 3 words.
- A details box under the grid describes the highlighted item in one plain
  sentence of what it does, up to 2 lines. Its title is the item's name.

## Keys

The same in every app: arrows or `hjkl` move, `space` toggles, `enter`
confirms, `q` or `esc` quits.

## Words

Plain labels that say what a thing is. No slogans, no themed names.

## Code

Go with Bubble Tea and Lip Gloss.
