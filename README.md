# Foritech — Post-Quantum File Security (Investor Demo)

[![Demo Only](https://img.shields.io/badge/demo-only-blue)](#)
[![Not for production](https://img.shields.io/badge/usage-not_for_production-orange)](#)
[![All rights reserved](https://img.shields.io/badge/license-all_rights_reserved-lightgrey)](#)
[![PQC: Kyber768](https://img.shields.io/badge/PQC-Kyber768-informational)](#)
[![CLI Available](https://img.shields.io/badge/CLI-available-success)](#)
[![Proprietary](https://img.shields.io/badge/code-proprietary-critical)](#)

---

## Overview
This repository provides an **investor-facing demonstration** of Foritech’s *post-quantum file security* system.  
It showcases the **experience and capabilities** of our SDK/CLI without exposing the core implementation.

Key features shown here:
- **Kyber768 KEM + ChaCha20-Poly1305 AEAD** wrapping/unwrapping.
- **Streaming container** (auto for large files, forced mode for small).
- **X.509 hybrid extensions** (raw/SPKI in private OIDs).
- **Lightweight TLS-PQC session demo**.
- **CI**: lightweight checks & documentation (full crypto tests live in the private repo).

---

## Live Demo (5 min)

1. **Install CLI from core project**  
   (Requires access to the private repo)

   ```bash
   git clone https://github.com/forrybg/foritech-secure-system.git
   cd foritech-secure-system
   python3 -m venv .venv && source .venv/bin/activate
   pip install -e .[dev]
   foritech --help

python - <<'PY'
import oqs, pathlib
p = pathlib.Path.home()/".foritech/keys"; p.mkdir(parents=True, exist_ok=True)
with oqs.KeyEncapsulation("Kyber768") as kem:
    pk, sk = kem.generate_keypair()
    (p/"kyber768_pub.bin").write_bytes(pk)
    (p/"kyber768_sec.bin").write_bytes(sk)
print("Keys at:", p)
PY
export FORITECH_SK="$HOME/.foritech/keys/kyber768_sec.bin"

bash scripts/demo_small_stream.sh
bash scripts/demo_big_stream.sh
bash scripts/demo_x509_spki.sh

Why Now

NIST has finalized ML-KEM (Kyber), pushing migration toward PQC.

Storage/backup/cloud exchanges are prime candidates for KEM + AEAD.

Our format is practical, compatible with liboqs, and integration-friendly.

Roadmap Snapshot

✅ Streaming container + tamper/order checks.

✅ X.509 raw/SPKI extensions & CLI.

✅ TLS-PQC session demo (KEM bootstrap + epochs).

⏭️ Multi-KEM fallback (Kyber+Classic).

⏭️ Docker image (liboqs + SDK) on GitHub Packages.

⏭️ PyPI “lite” package with graceful fallback.

Security Notes

Do not commit keys/secrets — always generate locally.

Containers are AEAD-authenticated with header MAC + frame checks.

Set FORITECH_SK for unwrap and TLS-PQC demos.

Usage Policy

This repository is provided for demonstration purposes only.
No production deployment, redistribution, or derivative works are permitted
without prior written consent.

License

All rights reserved © 2025 Forrybg
