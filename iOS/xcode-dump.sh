#!/usr/bin/env bash

# ==============================================================================
# TOKEN-OPTIMIZED CONTEXT DUMP
# Usage: ./xcode-dump.sh
# ==============================================================================

OUTPUT_FILE="xcode-dump.txt"
# Exclude git, build artifacts, pods, xcode project internals, assets, and tests to save space
EXCLUDED_PATTERNS="/.git/|/build/|/DerivedData/|/Pods/|Tests/|.xcodeproj/|/Assets.xcassets/|/.DS_Store"

# Start clean
echo "PROJECT DUMP" > "$OUTPUT_FILE"

# 1. File Structure (Minimal depth)
echo "SECTION: FILE STRUCTURE" >> "$OUTPUT_FILE"
find . -maxdepth 3 -not -path '*/.*' | grep -Ev "$EXCLUDED_PATTERNS" | sort >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 2. Swift Source Code
echo "SECTION: SWIFT SOURCE" >> "$OUTPUT_FILE"
find . -type f -name "*.swift" | grep -Ev "$EXCLUDED_PATTERNS" | sort | while read -r file; do
    echo ">>> FILE: $file" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

# 3. Config Files (Plist & Entitlements)
echo "SECTION: CONFIG" >> "$OUTPUT_FILE"
find . -type f \( -name "Info.plist" -o -name "*.entitlements" \) | grep -Ev "$EXCLUDED_PATTERNS" | sort | while read -r file; do
    echo ">>> FILE: $file" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "Done. Saved to $OUTPUT_FILE"