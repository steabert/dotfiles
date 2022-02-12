## Audio

### CD Ripping

Use the `abcde` program (which uses `cdparanoia` internally) and encode as flac

```shell
abcde -o flac -x
```

### Album covers

Download the `cover.jpg` and store in the folders, then resize all for use as tag and thumbnail

```shell
for d in */
do
  convert "${d}/cover.jpg" -resize 300x "${d}/cover-tag.jpg"
  convert "${d}/cover.jpg" -resize 32x32! "${d}/icon-tag.png"
done
```

### Tags

Fix tags if possible (with e.g. `picard` or some other program).

Then, add album art as tags:

```shell
for d in */
do
  for f in "$d"/*.flac
  do
    metaflac --import-picture-from="3|image/jpeg|||$d/cover-tag.jpg" "$f"
    metaflac --import-picture-from="1|image/png|||$d/icon-tag.png" "$f"
  done
done
```

### Replay gain

Compute replay gain and att to albums:

```shell
for d in */
do
  metaflac --add-replay-gain "$d"/*.flac
done
```
