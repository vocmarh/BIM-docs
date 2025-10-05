#!/usr/bin/env bash
set -euo pipefail

must_exist=(
  "docs/PLAN.md"
  "docs/WBS.md"
  "docs/DoD.md"
  "docs/RISKS.md"
  "docs/DECISIONS.md"
)

for f in "${must_exist[@]}"; do
  if [ ! -s "$f" ]; then
    echo "❌ Missing or empty: $f"
    exit 1
  else
    echo "✅ $f"
  fi
done

echo "✅ Basic structure OK"
