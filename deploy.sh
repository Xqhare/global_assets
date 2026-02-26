#!/usr/bin/env bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
if test -d "$PARENT_DIR/main"; then
	cd "$PARENT_DIR/main"
	./hook.sh
fi

if test -d "$PARENT_DIR/profile"; then
	cd "$PARENT_DIR/profile"
	./hook.sh
fi

if test -d "$PARENT_DIR/blog"; then
	cd "$PARENT_DIR/blog"
	./hook.sh
fi
