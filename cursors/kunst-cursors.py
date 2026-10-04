#!/usr/bin/env python3
# Builds ComixCursors-KunstOS from ComixCursors-Opaque-White:
# cursors bigger than the arrow are shrunk to the arrow's size, translucent light fill
# (the zoom lens) is made opaque, and the missing grab/hand1 names are added.
# usage: kunst-cursors.py <ComixCursors-Opaque-White dir> <output icons dir>
# needs magick, xcur2png and xcursorgen on PATH
import glob, os, shutil, subprocess, sys, tempfile

NAME = "ComixCursors-KunstOS"
LINKS = {"grab": "all-scroll", "hand1": "pointer"}  # all-scroll is the open hand

src = os.path.join(sys.argv[1], "cursors")
out = os.path.join(sys.argv[2], NAME)
tmp = tempfile.mkdtemp()


def frames(path):
    conf = os.path.join(tmp, os.path.basename(path) + ".conf")
    subprocess.run(["xcur2png", "-q", "-d", tmp, "-c", conf, path], check=True, capture_output=True)
    rows = [l.split("\t") for l in open(conf) if l.strip() and not l.startswith("#")]
    return [(int(s), int(x), int(y), png, int(d)) for s, x, y, png, d in rows]


def biggest_side(png):
    w, h = subprocess.run(["magick", png, "-trim", "-format", "%w %h", "info:"],
                          check=True, capture_output=True, text=True).stdout.split()
    return max(int(w), int(h))


def size32(fr):
    return next(f for f in fr if f[0] == 32)


limit = biggest_side(size32(frames(os.path.join(src, "default")))[3])

os.makedirs(os.path.join(out, "cursors"))
with open(os.path.join(out, "index.theme"), "w") as f:
    f.write(f"[Icon Theme]\nName = {NAME}\nComment = ComixCursors Opaque White, resized for KunstOS\nExample = default\n")

for path in sorted(glob.glob(os.path.join(src, "*"))):
    name = os.path.basename(path)
    target = os.path.join(out, "cursors", name)
    if os.path.islink(path):
        os.symlink(os.readlink(path), target)
        continue
    fr = frames(path)
    scale = min(1, limit / biggest_side(size32(fr)[3]))
    big = [f for f in fr if f[0] == 64]
    conf = os.path.join(tmp, name + ".new.conf")
    with open(conf, "w") as c:
        for size in sorted({f[0] for f in fr}):
            for i, (_, x, y, png0, delay) in enumerate(f for f in fr if f[0] == size):
                k = 1
                if scale < 1:  # redraw from the 64px frame so the shrunk cursor stays sharp
                    _, bx, by, png0, _ = big[i]
                    k = scale * size / 64
                    x, y = round(bx * k), round(by * k)
                png = os.path.join(tmp, f"{name}-{size}-{i}.png")
                subprocess.run(["magick", png0, "-resize", f"{k * 100}%", "-background", "none",
                                "-gravity", "NorthWest", "-extent", f"{size}x{size}",
                                "-channel", "A", "-fx", "(r+g+b)/3 > 0.5 && a > 0.25 ? 1 : a", png],
                               check=True)
                c.write(f"{size} {x} {y} {png} {delay}\n")
    subprocess.run(["xcursorgen", conf, target], check=True)

for name, to in LINKS.items():
    os.symlink(to, os.path.join(out, "cursors", name))

shutil.rmtree(tmp)
