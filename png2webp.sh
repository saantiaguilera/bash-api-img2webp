#!/bin/bash

WEBP_METHOD=6
WEBP_QUALITY=70
WORKING_DIR=$1

if [ ! -d "$WORKING_DIRECTORY" ]; then
    echo "Please provide a directory."
    echo "If you want to run it for a single image please use:"
    echo "cwebp -q QUALITY(70) -m METHOD(6) INPUT -o OUTPUT"
    exit 1
fi

FILES=$(find "${WORKING_DIR}" -print | grep -E ".*\.(png|jpg|jpeg)$")

current_dir=""
for ((i = 0; i < ${#FILES[@]}; i++)); do
    file="${FILES[$i]}"
    echo "$file -> file"
    
    dir=$(echo "$file" | sed -E "s%(.*)/[a-zA-Z0-9\-_]+\.(png|jpg|jpeg)$%\1%g" | sed "s%/%_%g")
    name=$(echo "$file" | sed -E "s%.*/([a-zA-Z0-9\-_]+\.)(png|jpg|jpeg)$%\1webp%g")

    # Check the current dir of the file exists, else create it.
    if [[ "$dir" != "$current_dir" ]]; then
        current_dir="$dir"
        mkdir "$current_dir"
    fi

    echo "Creating: $name"
    cwebp -q $WEBP_QUALITY -m $WEBP_METHOD "$file" -o "${current_dir}/$name" >/dev/null
    echo "Created."
    echo ""
done

echo "Finish."
