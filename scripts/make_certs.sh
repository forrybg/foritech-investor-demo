#!/usr/bin/env bash
set -euo pipefail
PUB="${HOME}/.foritech/keys/kyber768_pub.bin"
OUT_CERT="certs/server_cert.pem"
OUT_KEY="certs/server_key.pem"
mkdir -p certs
if [ ! -f "${PUB}" ]; then
  echo "[ERR] Missing Kyber768 public key: ${PUB}" >&2
  echo "      Generate with:  foritech keygen --kid kyber768" >&2
  exit 2
fi
echo "[*] Generating self-signed hybrid cert (SPKI) ..."
foritech x509-make --cn tls-demo --format spki \
  --pqc-pub "${PUB}" \
  --cert-out "${OUT_CERT}" \
  --key-out  "${OUT_KEY}"
chmod 600 "${OUT_KEY}" || true
echo "[OK] Wrote:"
ls -l "${OUT_CERT}" "${OUT_KEY}"
echo "[*] Inspecting hybrid extension ..."
foritech x509-info --in "${OUT_CERT}" || true
echo "[OK] Done."
