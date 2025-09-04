# Foritech Secure System — Investor One-Pager

## Problem
Enterprises must migrate to **post-quantum** crypto while keeping legacy PKI/TLS running. Today this is slow, complex, and risky.

## Solution
Drop-in toolkit for **PQC-ready PKI**:
- **Hybrid X.509/TLS** with Kyber/Dilithium
- **DID/SSI** identities + **Zero-Knowledge** authentication
- Open tooling (CLI/SDK) + reference gateway

## Why now
NIST PQC standardization, regulatory push for crypto-agility, and rising supply-chain attacks make migration urgent.

## Product
- **CLI/SDK** for key/cert ops and hybrid certs
- **Ref. gateway** for DID/ZK auth flows
- Docs, examples, CI, linkcheck; **NFT only as visual badge/license marker** (not a security primitive)

## Differentiation
Security-by-design, PQC-first, DID/ZK privacy, developer-friendly CLI/SDK, open approach.

## Stage / TRL
**TRL 4–5** today; target **TRL 6 by Oct 2025** with 2–3 SME pilots.

## KPIs (demo)
- TLS-PQC handshake success ≥ 99%
- Cert issue/verify < 0.5 s (local), handshake latency < 150 ms (local)
- CI pass rate 100%, 0 broken links

## Roadmap (next 60–90 days)
- End-to-end demo (issue → verify → ZK-login) + metrics
- Pilot integrations; docs hardening; security review
- v0.6.0 investor-ready release

## Ask
**€50k / 6 months** (EU micro-grant).
Use of funds → see Budget.

## Contact
foritech-secure-system (org) • demo site: this repo’s GitHub Pages
