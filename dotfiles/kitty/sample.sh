#!/usr/bin/env bash
# prints the 16 ANSI colors as text and blocks
for i in 0 1 2 3 4 5 6 7; do
  printf '\e[3%sm  normal %s  \e[9%sm  bright %s  \e[0m  \e[4%sm    \e[10%sm    \e[0m\n' $i $i $i $((i+8)) $i $i
done
printf '\n\e[1mbold\e[0m  \e[3mitalic\e[0m  \e[4munderline\e[0m  plain text\n\n'
git -C ~/projects/kunstOS log --oneline -1 2>/dev/null; ls --color=always ~/projects
