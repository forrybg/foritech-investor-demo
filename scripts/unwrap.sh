#!/usr/bin/env bash
set -euo pipefail
foritech unwrap --in s.enc --out s.out
diff -u s.txt s.out && echo "OK ✅"
