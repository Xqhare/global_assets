#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Global assets building script started"
echo #

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOCKFILE="/tmp/global_assets_build.lock"

# Use a subshell to manage the lock
(
    # Acquire an exclusive lock (wait if necessary)
    flock -x 200

    echo "Pulling global assets repository..."
    git pull origin master
    echo "Pulling global assets repository done."
    echo #

    # Get the current commit hash
    CURRENT_REV=$(git rev-parse HEAD)
    LAST_REV_FILE="$THIS_DIR/build/.last_rev"
    
    # Check if we should skip build
    SKIP_BUILD=false
    if [ -f "$LAST_REV_FILE" ] && [ "$(cat "$LAST_REV_FILE")" == "$CURRENT_REV" ] && [ -d "$THIS_DIR/build" ]; then
        # Also check if key files exist
        if [ -f "$THIS_DIR/build/footer.html" ] && [ -f "$THIS_DIR/build/header.html" ] && [ -f "$THIS_DIR/build/style.html" ] && [ -f "$THIS_DIR/build/favicon.png" ] && [ -f "$THIS_DIR/build/logo.png" ]; then
            SKIP_BUILD=true
        fi
    fi

    if [ "$SKIP_BUILD" = true ]; then
        echo "Global assets are up to date (Revision: $CURRENT_REV). Skipping rebuild."
    else
        echo "Setting up environment..."
        if test -d "$THIS_DIR/build"; then
                echo "Emptying old global assets build directory..."
                rm -rf "$THIS_DIR/build"
        fi
        mkdir -p "$THIS_DIR/build"
        echo "Setting up environment done."
        echo "- - - - - - - - - - - - - - - - - - - - - - - -"
        echo #

        echo "Building global assets..."
        
        echo "Building footer..."
        pandoc -f gfm-autolink_bare_uris -t html --metadata title="footer" --template="$THIS_DIR/templates/footer.html" -o "$THIS_DIR/build/footer.html" "$THIS_DIR/elements/footer.md"
        echo "Footer built."
        echo #

        echo "Building header..."
        pandoc -f gfm-autolink_bare_uris -t html --metadata title="header" --template="$THIS_DIR/templates/header.html" -o "$THIS_DIR/build/header.html" "$THIS_DIR/elements/header.md"
        echo "Header built."
        echo #

        echo "Building style include fragment..."
        echo "<style>" > "$THIS_DIR/build/style.html"
        cat "$THIS_DIR/css/main.css" >> "$THIS_DIR/build/style.html"
        echo "</style>" >> "$THIS_DIR/build/style.html"
        echo "Style include fragment built."
        echo #

        echo "Copying logo and favicon assets..."
        cp "$THIS_DIR/pictures/transparent_small_250x250.png" "$THIS_DIR/build/favicon.png"
        cp "$THIS_DIR/pictures/transparent_small_250x250.png" "$THIS_DIR/build/logo.png"
        echo "Copying logo and favicon assets done."
        echo #

        echo "Building global assets done."
        echo "- - - - - - - - - - - - - - - - - - - - - - - -"
        echo #

        # Save the current revision
        echo "$CURRENT_REV" > "$LAST_REV_FILE"
    fi
) 200>$LOCKFILE

echo "Global assets building script finished"
echo "------------------------------------------------"
exit 0
