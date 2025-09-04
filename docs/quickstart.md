# Quickstart (Demo Flow)

> This is the investor-demo path. Commands may differ while v0.5.x stabilizes. See the **core repo** for the latest steps.

1) Clone core:
```bash
git clone https://github.com/foritech-secure-system/foritech-secure-system.git
cd foritech-secure-system
Setup:
python -m venv .venv && source .venv/bin/activate
pip install -e .[dev]

Generate PQC keys (Kyber) and create a hybrid X.509 demo cert
(Replace with the final CLI names from the core repo when ready.)
# foritech keygen --kem Kyber768 --out ~/.foritech/keys/kyber768_pub.bin
# foritech x509-make --cn "Demo" --pqc-pub ~/.foritech/keys/kyber768_pub.bin --cert-out demo.pem --key-out demo.key

Run demo handshake (server/client) to show TLS-PQC path:
# python scripts/tls_pqc_server.py --cert demo.pem --key demo.key
# python scripts/tls_pqc_client.py --host 127.0.0.1 --port 8443

Outcome: successful handshake + log note for key-rotation signal.
For issues, see the core repo docs.
