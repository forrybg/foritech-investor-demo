# Foritech — Post-Quantum File Security (Investor Demo)

**TL;DR:** Реален SDK + CLI за *post-quantum* защита на файлове (Kyber768 KEM + AEAD), X.509 хибридни екстенции (raw/SPKI), и леки TLS-PQC сесии (демо).  
**Статус:** стабилен MVP с auto-streaming, tamper checks, и 13+ теста (green).  

## Highlights
# - **Wrap/Unwrap с Kyber768 (liboqs)** и ChaCha20-Poly1305 (AEAD).
# - **Streaming контейнер** (авто над 64MiB; forced флаг за малки файлове).
# - **X.509 хибридни екстенции**: raw и SPKI-b64 в private OID; CLI: `x509-make`, `x509-info`, `x509-extract-pqc`.
# - **TLS-PQC session demo**: еднократен KEM обмен + симетрична сесия; ping/pong и rotatable epochs.
# - **CI**: леки проверки и док; full crypto тестове – отделно (изискват liboqs).

> Този репозиторий показва *демо изживяване*. Истинският код е в основното repo:
> - Core SDK/CLI: `forrybg/foritech-secure-system`

#---

## Live Demo (5 мин)

> Предпоставки: Python 3.12+, `foritech` CLI инсталиран от основното репо (editable), Kyber ключове.

1) **Инсталация на CLI (от основния проект)**
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

NIST финализира ML-KEM (Kyber) → натиск към PQC миграция.

Storage/backup/cloud обмените са low hanging fruit за PQC KEM + AEAD.

Нашият формат е прост, практичен и съвместим с liboqs.

Roadmap Snapshot

✅ Streaming контейнер + SEC-1..3 проверки (tamper/order/strict).

✅ X.509 raw/SPKI екстенции и CLI.

✅ TLS-PQC session demo (KEM bootstrap + epochs).

⏭️ Multi-KEM fallback (Kyber+Classic).

⏭️ Docker образ (liboqs + SDK) и GitHub Packages.

⏭️ PyPI „lite“ пакет с graceful fallback при липса на liboqs.

Security Notes

Не комитвайте ключове/секрети. Генерирайте локално.

Контейнерът е AEAD-authenticated; header MAC + frame checks.

Настройте FORITECH_SK за unwrap и TLS-PQC демо.

License

MIT
