> **CONFIDENTIAL — For investors only**  
> Unauthorized sharing or redistribution is prohibited.

---

# Foritech — Investor Pitch (Short)

**Problem:** Classical RSA/ECDH key exchange will be vulnerable to future quantum attacks.  

**Solution:** Lightweight and practical file container (Kyber768 KEM + AEAD),  
X.509 hybrid extensions, and TLS-PQC session demos — with a working SDK/CLI.

**Why Us:**  
- Focus on real use cases (backup/restore, S3/MinIO data exchange).  
- Easy integration and developer experience.  
- Streaming support for large files + security checks (tamper/order).  

**Traction:**  
- Green CI, running demos, roadmap toward Docker / PyPI / Hybrid TLS.

---

## Roadmap Snapshot
- ✅ Streaming container with tamper/order checks.  
- ✅ X.509 raw/SPKI extensions & CLI.  
- ✅ TLS-PQC session demo (KEM bootstrap + epochs).  
- ⏭️ Multi-KEM fallback (Kyber+Classic).  
- ⏭️ Docker image (liboqs + SDK).  
- ⏭️ PyPI “lite” package with graceful fallback.  

---

## Security & Licensing
- This demo is **not for production** use.  
- Keys/secrets must always be generated locally.  
- The core SDK remains **closed-source and proprietary**.  

---

> **CONFIDENTIAL — For investors only**  
> All rights reserved © 2025 Forrybg
