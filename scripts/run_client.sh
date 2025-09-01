#!/usr/bin/env bash
set -euo pipefail
HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-8443}"
PY="${PY:-../foritech-secure-system/.venv/bin/python}"
exec "$PY" ../foritech-secure-system/scripts/tls_pqc_client.py --host "$HOST" --port "$PORT"
