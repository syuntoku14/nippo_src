#1/usr/bin/env bash
set -e

cat << EOF
---
title: 日報
---
<!-- no RSS feeds, check back every day :love: -->
EOF
ls src/*.md | sort -nr |
while read f; do
  date=$(basename "$f" .md | sed -e "s/src\///")
  echo "- [$date](./$date.html)"
done

