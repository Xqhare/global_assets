#!/usr/bin/env bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if test -d "$THIS_DIR/build"; then
	echo "Removing old build directory"
	rm -rf "$THIS_DIR/build"
fi
mkdir -p "$THIS_DIR/build"

pandoc -f gfm -t html -o "$THIS_DIR/build/footer.html" "$THIS_DIR/elements/footer.md"
