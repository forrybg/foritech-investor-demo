#!/usr/bin/env bash
set -euo pipefail
echo "hi" > s.txt
foritech wrap --in s.txt --out s.enc --recipient raw:$HOME/.foritech/keys/kyber768_pub.bin --kid demo
echo "wrapped to s.enc"
