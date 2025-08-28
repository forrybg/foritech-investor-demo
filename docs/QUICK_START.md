#!/usr/bin/env bash
# Foritech Investor Demo - Quick Start

This repo is a tiny TLS+PQC demo that uses the Foritech SDK from the sibling repo.
We re-use its Python (has cryptography and oqs) and only keep certs here.

## 0) Prereqs

- Main repo is at `../foritech-secure-system` with a working venv:
  - `../foritech-secure-system/.venv/bin/python` exists
  - `cryptography` and `oqs` are installed there
- Kyber768 keypair under `~/.foritech/keys/`:
  - `kyber768_pub.bin` (1184 bytes)
  - `kyber768_sec.bin` (2400 bytes)

## 1) Generate a self-signed hybrid X.509 (SPKI)

From this repo root:

bash
mkdir -p certs
foritech x509-make --cn tls-demo --format spki \
  --pqc-pub "$HOME/.foritech/keys/kyber768_pub.bin" \
  --cert-out certs/server_cert.pem \
  --key-out  certs/server_key.pem
chmod 600 certs/server_key.pem


Check the FORITECH extension:

bash
foritech x509-info --in certs/server_cert.pem
# expect: X509: kem=Kyber768 format=spki-b64 ...


Tip: `scripts/make_certs.sh` performs the same steps.

## 2) Run server and client

Use Python from the main repo (already has deps):

bash
export FORITECH_SK="$HOME/.foritech/keys/kyber768_sec.bin"
make PY=../foritech-secure-system/.venv/bin/python server
# expect: "Server on https://0.0.0.0:8443 ..."


In another terminal:

bash
make PY=../foritech-secure-system/.venv/bin/python client
# expect: OK and session rotation (epoch 0 -> 1)


## 3) One-shot checks

bash
scripts/doctor.sh


It verifies `FORITECH_SK`, `cryptography+oqs` availability and the cert presence.



## Troubleshooting

- **Server cert has no FORITECH hybrid extension**
  - Re-generate with step 1 (`foritech x509-make --format spki ...`).
  - Restart the server.

- **Address already in use (port 8443)**
  - Kill stale listener:
    `fuser -k 8443/tcp 2>/dev/null || pkill -f tls_pqc_server.py || true`
  - Start server again.

- **Missing oqs / cryptography**
  - Always run with the Python from the main repo:
    `make PY=../foritech-secure-system/.venv/bin/python server`

- **KEY_VALUES_MISMATCH**
  - `server_cert.pem` does not match `server_key.pem`.
  - Re-run step 1 to generate a matching pair.



## Notes

- The demo uses a self-signed leaf for HTTPS; the PQC key is embedded via
  FORITECH hybrid extension (SPKI encoding).
- For production, issue the leaf from your Issuing CA (we already have Root/Sub-CA
  tooling in the main repo), rotate on schedule and maintain CRLs/OCSP.
  For the investor demo, self-signed is simpler and sufficient.

Enjoy!
