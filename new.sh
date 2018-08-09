#!/usr/bin/env bash
set -euxo pipefail
d=$(date +%F)
fp="src/$d.md"
template=$(cat << EOF
---
title: 日報 $d
---

|||
|:-|:-:|

## 日課

- [ ] Control of Mobile Robots
- [ ] Control Tutorials
- [ ] Rust
EOF
)
if [ -f "$fp" ]; then
  echo "file already exists at $fp"
  exit 1
else
  echo "creating entry at $fp"
  echo "$template" > $fp
fi
