#!/bin/bash

SOURCE_DIR="images/fulls"
THUMB_DIR="images/thumbs"

mkdir -p "$THUMB_DIR"

for img in "$SOURCE_DIR"/*.{jpg,JPG,jpeg,JPEG}; do
    [ -e "$img" ] || continue

    filename=$(basename "$img")

    # Replace whitespace with underscores in the full image filename
    safe_filename="${filename// /_}"

    if [ "$filename" != "$safe_filename" ]; then
        echo "Renaming: $filename -> $safe_filename"
        mv "$img" "$SOURCE_DIR/$safe_filename"
        img="$SOURCE_DIR/$safe_filename"
    fi

    thumb_path="$THUMB_DIR/$safe_filename"

    # Skip thumbnail creation if it already exists
    if [ -e "$thumb_path" ]; then
        echo "Skipping existing thumbnail: $safe_filename"
        continue
    fi

    echo "Creating thumbnail: $safe_filename"

    magick "$img" \
        -resize "700x700>" \
        -strip \
        -quality 80 \
        "$thumb_path"
done

echo "Done."