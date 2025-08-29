# Troubleshooting

## "Server cert has no FORITECH hybrid extension"
Regenerate self-signed hybrid cert (SPKI):
foritech x509-make --cn tls-demo --format spki \
  --pqc-pub "$HOME/.foritech/keys/kyber768_pub.bin" \
  --cert-out certs/server_cert.pem --key-out certs/server_key.pem

## "Address already in use"
Free port 8443:
fuser -k 8443/tcp 2>/dev/null || pkill -f tls_pqc_server.py || true

## "ModuleNotFoundError: oqs"
Install OQS bindings in this venv (or use the main repo’s Python):
bash third_party/dev_install_oqs.sh
# OR run: make PY=../foritech-secure-system/.venv/bin/python server/client

## "KEY_VALUES_MISMATCH" (SSL)
Your cert/key don’t match. Re-issue:
foritech x509-make --cn tls-demo --format spki \
  --pqc-pub "$HOME/.foritech/keys/kyber768_pub.bin" \
  --cert-out certs/server_cert.pem --key-out certs/server_key.pem
