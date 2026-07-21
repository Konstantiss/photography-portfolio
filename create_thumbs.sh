#!/bin/bash

SOURCE_DIR="images/fulls"
THUMB_DIR="images/thumbs"

mkdir -p "$THUMB_DIR"

for img in "$SOURCE_DIR"/*.{jpg,JPG,jpeg,JPEG}; do
    [ -e "$img" ] || continue

    filename=$(basename "$img")

    echo "Creating thumbnail: $filename"

    magick "$img" \
        -resize "700x700>" \
        -strip \
        -quality 80 \
        "$THUMB_DIR/$filename"
done

echo "Done."