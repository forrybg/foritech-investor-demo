# Foritech Investor Demo

Minimal demo to show:
- PQC TLS session (Kyber768) with our sample server/client
- File wrap/unwrap via the `foritech` CLI

## 0) Prepare venv

```bash
python3 -m venv .venv
source .venv/bin/activate
# Install the SDK from the sibling repo:
pip install -e ../foritech-secure-system

If you want Kyber (TLS-PQC) support, also ensure liboqs and oqs python are installed as per the main repo’s scripts/dev_install_oqs.sh.
1) Bring certs/keys

Copy a fullchain + server key here (or point the run script to your files):
cp ../foritech-secure-system/pki/issued/leaf-sub1_fullchain.pem certs/server_cert.pem
cp ../foritech-secure-system/pki/issued/leaf-sub1.key         certs/server_key.pem

Export Kyber secret (if different, adjust path):
export FORITECH_SK="$HOME/.foritech/keys/kyber768_sec.bin"

2) Run

Terminal A:
scripts/run_server.sh

Terminal B:
scripts/run_client.sh

You should see the KEM info and a pong:... reply.
3) File wrap/unwrap smoke
echo "hi" > s.txt
foritech wrap --in s.txt --out s.enc --recipient raw:$HOME/.foritech/keys/kyber768_pub.bin --kid demo
foritech unwrap --in s.enc --out s.out
diff -u s.txt s.out && echo "OK ✅"

This demo repo intentionally ignores certs/ in git. Do not commit secrets.
