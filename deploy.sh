#!/usr/bin/env bash
set -e

echo "------------------------------------------------"
echo #
echo "Deploying global assets script started"
echo #

MAIN_DIR_UPDATED=false
PROFILE_DIR_UPDATED=false
BLOG_DIR_UPDATED=false

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

if test -d "$PARENT_DIR/main"; then
        echo "Deploying global assets to main service..."
        cd "$PARENT_DIR/main"
        ./hook.sh
        MAIN_DIR_UPDATED=true
        echo "Main service updated."
        echo #
fi

if test -d "$PARENT_DIR/profile"; then
        echo "Deploying global assets to profile service..."
        cd "$PARENT_DIR/profile"
        ./hook.sh
        PROFILE_DIR_UPDATED=true
        echo "Profile service updated."
        echo #
fi

if test -d "$PARENT_DIR/blog"; then
        echo "Deploying global assets to blog service..."
        cd "$PARENT_DIR/blog"
        ./hook.sh
        BLOG_DIR_UPDATED=true
        echo "Blog service updated."
        echo #
fi

if ! $MAIN_DIR_UPDATED; then
        echo "ERROR: Missing main directory at $PARENT_DIR/main"
        exit 1
fi

if ! $PROFILE_DIR_UPDATED; then
        echo "ERROR: Missing profile directory at $PARENT_DIR/profile"
        exit 1
fi

if ! $BLOG_DIR_UPDATED; then
        echo "ERROR: Missing blog directory at $PARENT_DIR/blog"
        exit 1
fi

echo "Deploying global assets done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Deploying global assets script finished"
echo "------------------------------------------------"
exit 0
