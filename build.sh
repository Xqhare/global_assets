#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Global assets building script started"
echo #
echo "Pulling global assets"
echo #
git pull origin master
echo #
echo "Pulling global assets done"
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
echo "Building header"
pandoc -f gfm-autolink_bare_uris -t html --metadata title="header" --template="$THIS_DIR/templates/header.html" -o "$THIS_DIR/build/header.html" "$THIS_DIR/elements/header.md"

echo "Header built"
echo #
echo "Building style"
echo #
echo "Generate CSS include fragment"
echo "<style>" > "$THIS_DIR/build/style.html"
cat "$THIS_DIR/css/main.css" >> "$THIS_DIR/build/style.html"
echo "</style>" >> "$THIS_DIR/build/style.html"
echo "Generate CSS include fragment done"
echo #
echo "Style built"
echo #
echo "Building script done"
echo "------------------------------------------------"
exit 0
