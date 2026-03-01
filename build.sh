#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Global assets building script started"
echo #

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOCKFILE="/tmp/global_assets_build.lock"

# Use a subshell to manage the lock
(
    set -e
    # Acquire an exclusive lock (wait if necessary)
    flock -x 200

    echo "Pulling global assets repository..."
    git pull origin master
    echo "Pulling global assets repository done."
    echo #

    # Get the current commit hash - this will be our cache-busting version
    CURRENT_REV=$(git rev-parse --short HEAD)
    
    TMP_BUILD="$THIS_DIR/build_tmp"
    if test -d "$TMP_BUILD"; then
            rm -rf "$TMP_BUILD"
    fi
    mkdir -p "$TMP_BUILD"

    echo "Building global assets into temporary directory (Version: $CURRENT_REV)..."
    
    # Save version for other services to use
    echo "$CURRENT_REV" > "$TMP_BUILD/version.txt"

    echo "Building footer..."
    pandoc -f gfm-autolink_bare_uris -t html --metadata title="footer" --template="$THIS_DIR/templates/footer.html" -o "$TMP_BUILD/footer.html" "$THIS_DIR/elements/footer.md"
    echo "Footer built."
    echo #

    echo "Building header..."
    # We pass the asset version to the header build
    pandoc -f gfm-autolink_bare_uris -t html --metadata title="header" --metadata asset_v="$CURRENT_REV" --template="$THIS_DIR/templates/header.html" -o "$TMP_BUILD/header.html" "$THIS_DIR/elements/header.md"
    echo "Header built."
    echo #

    echo "Building style include fragment..."
    echo "<style>" > "$TMP_BUILD/style.html"
    cat "$THIS_DIR/css/main.css" >> "$TMP_BUILD/style.html"
    echo "</style>" >> "$TMP_BUILD/style.html"
    echo "Style include fragment built."
    echo #

    echo "Copying logo and favicon assets..."
    if [ -f "$THIS_DIR/pictures/transparent_small_250x250_shifted.png" ]; then
        cp "$THIS_DIR/pictures/transparent_small_250x250_shifted.png" "$TMP_BUILD/favicon.png"
        cp "$THIS_DIR/pictures/transparent_small_250x250_shifted.png" "$TMP_BUILD/logo.png"
    else
        cp "$THIS_DIR/pictures/transparent_small_250x250.png" "$TMP_BUILD/favicon.png"
        cp "$THIS_DIR/pictures/transparent_small_250x250.png" "$TMP_BUILD/logo.png"
    fi
    echo "Copying logo and favicon assets done."
    echo #

    echo "Swapping temporary build with live build directory..."
    if test -d "$THIS_DIR/build"; then
        rm -rf "$THIS_DIR/build"
    fi
    mv "$TMP_BUILD" "$THIS_DIR/build"
    
    # Save the current revision for the legacy Rev file
    echo "$CURRENT_REV" > "$THIS_DIR/build/.last_rev"

    echo "Building global assets done."
    echo "- - - - - - - - - - - - - - - - - - - - - - - -"
    echo #
    
    echo "Global assets building script finished"
    echo "------------------------------------------------"
) 200>$LOCKFILE

exit 0
