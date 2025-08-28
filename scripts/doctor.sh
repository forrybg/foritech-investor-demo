#!/usr/bin/env bash
set -euo pipefail
echo "== Foritech Demo Doctor =="
# Python check (prefer sibling venv if present)
PY="${PY:-}"
if [ -z "${PY}" ] && [ -x "../foritech-secure-system/.venv/bin/python" ]; then
  PY="../foritech-secure-system/.venv/bin/python"
fi
if [ -z "${PY}" ]; then
  PY="$(command -v python3 || command -v python)"
fi
echo "[*] Python: ${PY}"
"${PY}" -c "import sys; print('python', sys.version.split()[0])"
# crypto libs
if "${PY}" -c "import cryptography, oqs" 2>/dev/null; then
  echo "[OK] cryptography + oqs available"
else
  echo "[ERR] Missing 'cryptography' and/or 'oqs' in ${PY}" >&2
  echo "     Tip: use the main repo venv: PY=../foritech-secure-system/.venv/bin/python" >&2
fi
# SK env var
if [ -n "${FORITECH_SK:-}" ] && [ -f "${FORITECH_SK}" ]; then
  echo "[OK] FORITECH_SK set -> ${FORITECH_SK}"
else
  echo "[WARN] FORITECH_SK not set or file missing." >&2
  echo "      export FORITECH_SK=\"\$HOME/.foritech/keys/kyber768_sec.bin\"" >&2
fi
# cert presence
if [ -f certs/server_cert.pem ]; then
  echo "[*] Cert present: certs/server_cert.pem"
  if command -v foritech >/dev/null 2>&1; then
    foritech x509-info --in certs/server_cert.pem || true
  fi
else
  echo "[WARN] No certs/server_cert.pem (run scripts/make_certs.sh)" >&2
fi
if [ -f certs/server_key.pem ]; then
  echo "[*] Key present: certs/server_key.pem (perms: \$(stat -c %a certs/server_key.pem 2>/dev/null || echo '?'))"
else
  echo "[WARN] No certs/server_key.pem (run scripts/make_certs.sh)" >&2
fi
echo "[i] If 8443 is busy:  fuser -k 8443/tcp 2>/dev/null || pkill -f tls_pqc_server.py || true"
echo "[OK] Doctor finished."
