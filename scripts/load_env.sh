#!/usr/bin/env bash
set -euo pipefail
if [[ -f .env ]]; then
  set -a
  source .env
  set +a
  echo "Loaded env from .env"
else
  echo "No .env; copy from .env.example and edit."
fi
