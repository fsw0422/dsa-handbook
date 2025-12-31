#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POSTS_DIR="$SCRIPT_DIR/posts"
OUTPUT_FILE="$SCRIPT_DIR/dsa-handbook.pdf"

# Collect markdown files
mapfile -t MD_FILES < <(find "$POSTS_DIR" -maxdepth 1 -name '*.md' | sort)

if [[ ${#MD_FILES[@]} -eq 0 ]]; then
    echo "No markdown files found in $POSTS_DIR"
    exit 0
fi

echo "Converting ${#MD_FILES[@]} markdown files to PDF..."
for f in "${MD_FILES[@]}"; do
    echo "  - $(basename "$f")"
done
echo

pandoc "${MD_FILES[@]}" \
    -o "$OUTPUT_FILE" \
    --pdf-engine=pdflatex \
    -V geometry:margin=1in \
    -V fontsize=11pt \
    -V documentclass=article \
    --toc \
    --highlight-style=tango

echo "Conversion complete!"
echo "Output: $OUTPUT_FILE"
