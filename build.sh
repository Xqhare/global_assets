#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Building script started"
echo #
echo "Setting up environment"
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if test -d "$THIS_DIR/build"; then
	echo "Emptying old global assets build directory"
	rm -rf "$THIS_DIR/build"
fi
mkdir -p "$THIS_DIR/build"
echo "Setting up environment done"
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Building global assets"
echo #
echo "Building footer"
pandoc -f gfm-autolink_bare_uris -t html --metadata title="footer" --template="$THIS_DIR/templates/footer.html" -o "$THIS_DIR/build/footer.html" "$THIS_DIR/elements/footer.md"

echo "Footer built"
echo #
echo "Building style"

# Generate CSS include fragment
echo "<style>" > "$THIS_DIR/build/style.html"
cat "$THIS_DIR/css/main.css" >> "$THIS_DIR/build/style.html"
echo "</style>" >> "$THIS_DIR/build/style.html"

echo "Style built"
echo #
echo "Building script done"
echo "------------------------------------------------"
exit 0
