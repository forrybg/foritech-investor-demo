#!/usr/bin/env bash
set -euo pipefail

PY="${PY:-python3}"
echo "PY: $("$PY" -c 'import sys; print(sys.executable)')"

# 1) imports
"$PY" - <<'PY'
import importlib, sys
for m in ("oqs","cryptography","foritech"):
    try:
        importlib.import_module(m)
        print(f"[OK] import {m}")
    except Exception as e:
        print(f"[ERR] import {m}: {e}")
        raise SystemExit(2)
PY

# 2) files
test -f certs/server_cert.pem || { echo "[ERR] missing certs/server_cert.pem"; exit 2; }
test -f certs/server_key.pem  || { echo "[ERR] missing certs/server_key.pem";  exit 2; }

# 3) hybrid extension present?
if ! foritech x509-info --in certs/server_cert.pem 2>/dev/null | grep -q 'format=spki'; then
  echo "[ERR] server_cert.pem is not FORITECH hybrid (SPKI). Re-run x509-make."
  exit 2
fi
echo "[OK] Hybrid X.509 (SPKI) detected"

# 4) port free?
if command -v fuser >/dev/null && fuser 8443/tcp >/dev/null 2>&1; then
  echo "[WARN] TCP 8443 appears busy. You may need:"
  echo "  fuser -k 8443/tcp 2>/dev/null || pkill -f tls_pqc_server.py || true"
else
  echo "[OK] TCP 8443 seems free"
fi

echo "[OK] Doctor finished."
