#!/usr/bin/env bash
# Build presentation.html from fragments
# Usage: ./build.sh [en]

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "${1:-}" == "en" ]]; then
  SUFFIX="-en"
  OUT="presentation-en.html"
else
  SUFFIX=""
  OUT="presentation.html"
fi

HEADER="$DIR/academic-light.css"
PARTS=(
  "$DIR/ch-opening${SUFFIX}.html"
  "$DIR/ch-part1${SUFFIX}.html"
  "$DIR/ch-part2${SUFFIX}.html"
  "$DIR/ch-part3${SUFFIX}.html"
  "$DIR/ch-closing${SUFFIX}.html"
)

# Verify all fragments exist
for f in "$HEADER" "${PARTS[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Missing: $f" >&2
    exit 1
  fi
done

{
  echo '<!DOCTYPE html>'
  echo '<html lang="zh-CN">'
  echo '<head>'
  echo '<meta charset="UTF-8">'
  echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
  echo '<title>CC Research Playbook</title>'
  echo '<style>'
  cat "$HEADER"
  echo '</style>'
  echo '</head>'
  echo '<body>'
  for part in "${PARTS[@]}"; do
    cat "$part"
  done
  echo '</body>'
  echo '</html>'
} > "$DIR/$OUT"

echo "Built: slides/$OUT"
