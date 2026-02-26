#!/usr/bin/env bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if test -d "$THIS_DIR/build"; then
	echo "Removing old global assets build directory"
	rm -rf "$THIS_DIR/build"
fi
mkdir -p "$THIS_DIR/build"

pandoc -f gfm-autolink_bare_uris -t html --metadata title="footer" --template="$THIS_DIR/templates/footer.html" -o "$THIS_DIR/build/footer.html" "$THIS_DIR/elements/footer.md"

# Generate CSS include fragment
echo "<style>" > "$THIS_DIR/build/style.html"
cat "$THIS_DIR/css/main.css" >> "$THIS_DIR/build/style.html"
echo "</style>" >> "$THIS_DIR/build/style.html"
