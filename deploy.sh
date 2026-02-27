#!/usr/bin/env bash

MAIN_DIR_UPDATED=false
PROFILE_DIR_UPDATED=false
BLOG_DIR_UPDATED=false

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
if test -d "$PARENT_DIR/main"; then
	cd "$PARENT_DIR/main"
	./hook.sh
	MAIN_DIR_UPDATED=true
fi

if test -d "$PARENT_DIR/profile"; then
	cd "$PARENT_DIR/profile"
	./hook.sh
	PROFILE_DIR_UPDATED=true
fi

if test -d "$PARENT_DIR/blog"; then
	cd "$PARENT_DIR/blog"
	./hook.sh
	BLOG_DIR_UPDATED=true
fi

if ! $MAIN_DIR_UPDATED; then
	echo "ERROR: Missing main directory at $PARENT_DIR/main"
fi

if ! $PROFILE_DIR_UPDATED; then
	echo "ERROR: Missing profile directory at $PARENT_DIR/profile"
fi

if ! $BLOG_DIR_UPDATED; then
	echo "ERROR: Missing blog directory at $PARENT_DIR/blog"
fi

if ! $MAIN_DIR_UPDATED || ! $PROFILE_DIR_UPDATED || ! $BLOG_DIR_UPDATED; then
	exit 1
else
	exit 0
fi

