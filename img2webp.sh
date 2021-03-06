#!/bin/bash

# For api customization please check https://developers.google.com/speed/webp/docs/cwebp

WEBP_METHOD=6
WEBP_QUALITY=70

SUPPORTED_EXT="png|jpg|jpeg"
FINAL_EXT="webp"

WORKING_DIR=$1

if [ ! -d "$WORKING_DIR" ]; then
    echo "Please provide a directory."
    echo "If you want to run it for a single image please use:"
    echo "cwebp -q QUALITY(70) -m METHOD(6) INPUT -o OUTPUT"
    exit 1
fi

FILES=($(find "${WORKING_DIR}" -print | grep -E "^[^\.]+\.(${SUPPORTED_EXT})$")) # This regex is done like this to avoid nine patchs.

current_dir=""
for ((i = 0; i < ${#FILES[@]}; i++)); do
    file="${FILES[$i]}"
    
    dir=$(echo "$file" | sed -E "s%(.*)/[a-zA-Z0-9\-_]+\.(${SUPPORTED_EXT})$%\1%g" | sed "s%/%_%g")
    name=$(echo "$file" | sed -E "s%.*/([a-zA-Z0-9\-_]+\.)(${SUPPORTED_EXT})$%\1${FINAL_EXT}%g")

    # Check the current dir of the file exists, else create it.
    if [[ "$dir" != "$current_dir" ]]; then
        current_dir="$dir"
        mkdir "$current_dir" >/dev/null
    fi

    echo "Creating: $name"
    cwebp -q $WEBP_QUALITY -m $WEBP_METHOD "$file" -o "${current_dir}/$name" -quiet
    echo "Created."
    echo ""
done

echo "Finish."
