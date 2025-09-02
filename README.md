# Foritech Investor Demo

docs-polish
![Docs check](https://github.com/forrybg/foritech-investor-demo/actions/workflows/docs-check.yml/badge.svg)
![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

## Investor Docs (overview)
- **Landing / One-pager** → [docs/landing.md](docs/landing.md)
- **Pitch** → [docs/pitch.md](docs/pitch.md)
- **Funding plan & Budget** → [docs/funding.md](docs/funding.md) · [docs/budget.xlsx](docs/budget.xlsx)
- **Architecture** → [docs/architecture.md](docs/architecture.md)
- **TRL & KPI** → [docs/trl.md](docs/trl.md)
- **Timeline & Roadmap** → [docs/timeline.md](docs/timeline.md) · [docs/roadmap.md](docs/roadmap.md)
- **Risks & Mitigations** → [docs/risks.md](docs/risks.md)
- **Security checklist (GDPR notes)** → [docs/SECURITY_CHECKLIST.md](docs/SECURITY_CHECKLIST.md)

> This repository contains the public investor/demo documentation pack.  
> Core implementation lives in the main project repository.

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

---

## Quickstart

### One-time: self-signed hybrid cert (SPKI)
```bash
foritech x509-make --cn tls-demo --format spki \
  --pqc-pub "$HOME/.foritech/keys/kyber768_pub.bin" \
  --cert-out certs/server_cert.pem --key-out certs/server_key.pem
foritech x509-info --in certs/server_cert.pem  # expect: format=spki-b64

Run
# Option A (use main repo Python with oqs+cryptography)
make PY=../foritech-secure-system/.venv/bin/python server
make PY=../foritech-secure-system/.venv/bin/python client

# Option B (use this demo venv + install oqs)
bash third_party/dev_install_oqs.sh
make server
make client

Troubleshooting
See docs/TROUBLESHOOTING.md
.
Doctor
make doctor


## LAN сценарий (сървър на машина A, клиент на машина B)

**На машина A (Linux, където е сървърът):**
```bash
cd ~/foritech-investor-demo
export FORITECH_SK="$HOME/.foritech/keys/kyber768_sec.bin"
HOST=0.0.0.0 PORT=8443 make PY=../foritech-secure-system/.venv/bin/python server

На машина B (Linux, клиент):
cd ~/foritech-investor-demo
HOST=<IP-на-машина-A> PORT=8443 make PY=../foritech-secure-system/.venv/bin/python client
# или:
HOST=<IP-на-машина-A> PORT=8443 ./scripts/run_client.sh

Ако получиш Connection refused, провери:

дали сървърът на A слуша (0.0.0.0:8443),

дали няма локален firewall,

дали клиентът ползва правилния PY път до Python-а, където са инсталирани зависимостите.

---
**Investor Docs Pack** lives in this repo under [/docs](./docs).
Core repo → https://github.com/forrybg/foritech-secure-system

## Policies
- **Security Policy:** see [`.github/SECURITY.md`](.github/SECURITY.md)
- **Code of Conduct:** see [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md)
main
