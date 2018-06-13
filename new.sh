#!/usr/bin/env bash
set -e
d=$(date +%F)
fp="src/$d.md"
template=$(cat << EOF
---
title: 日報 $d
---

|||
|:-|:-:|

## 日課

- [ ] タイピングの練習
	+ [ ] 寿司打
	+ [ ] e-typing
	+ [ ] typing.io
- [ ] Anki
- [ ] 筋肉を使う
	+ [ ] 腹筋
	+ [ ] 腕立て伏せ
	+ [ ] 体幹を使う
- [ ] 読書

EOF
)
if [ -f "$fp" ]; then
  echo "file already exists at $fp"
  exit 1
else
  echo "creating entry at $fp"
  echo "$template" > $fp
fi
