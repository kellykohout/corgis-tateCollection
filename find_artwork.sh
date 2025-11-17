#!/usr/bin/env bash
# Usage: ./find_artwork.sh -i "<title>" -d /path/to/folder
# Input: artwork_data.csv (CSV) must exist inside the folder.
# Output: artist<TAB>title<TAB>medium<TAB>year for matches, then a final count line.

set -euo pipefail  # safer Bash: exit on errors, unset vars, failed pipelines

# Variables
TITLE=""; DATA_DIR=""; CSV=""

# Usage function
usage() {
  echo "Usage: $0 -i \"<title>\" -d /path/to/folder"
  echo " -i title to search (case-insensitive exact match)"
  echo " -d folder containing artwork_data.csv"
  echo " -h show help"
}

# Parse flags
while getopts ":i:d:h" opt; do
  case "$opt" in
    i) TITLE="$OPTARG" ;;
    d) DATA_DIR="$OPTARG" ;;
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

# Validate inputs
[ -z "${TITLE:-}" ] && { echo "ERROR: -i <title> is required" >&2; usage; exit 1; }
[ -z "${DATA_DIR:-}" ] && { echo "ERROR: -d /path/to/folder is required" >&2; usage; exit 1; }

CSV="$DATA_DIR/artwork_data.csv"
[ -s "$CSV" ] || { echo "ERROR: $CSV not found or empty." >&2; exit 1; }

# Check csvkit tools
for cmd in csvcut csvgrep csvformat; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "ERROR: $cmd not found. Please install csvkit." >&2; exit 1; }
done

# Pipeline:
tmp_matches="$(mktemp)"

# Step 1: select title, artist, medium, year columns
# Step 2: filter exact title (case-insensitive)
# Step 3: select desired columns
# Step 4: format as TSV
# Step 5: remove header
csvcut -c title,artist,medium,year "$CSV" \
  | csvgrep -c title -r "(?i)^${TITLE}$" \
  | csvformat -T \
  | tail -n +2 \
  | tee "$tmp_matches"

# Count matches
count="$(wc -l < "$tmp_matches" | tr -d ' ')"

# Summary
echo "----"
echo "Found ${count} artwork(s) titled: \"${TITLE}\""

# Cleanup
rm -f "$tmp_matches"
