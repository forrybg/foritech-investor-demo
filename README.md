# FORITECH — Investor Demo Pack

[![Docs link check](https://github.com/forrybg/foritech-investor-demo/actions/workflows/docs-check.yml/badge.svg)](https://github.com/forrybg/foritech-investor-demo/actions/workflows/docs-check.yml)

This repository contains the **investor-facing documentation pack** and **demo helper scripts** for the FORITECH secure system.
The core implementation (SDK, tests, PQC/TLS integration) lives in the main repo:  
➡️ **foritech-secure-system**: [core repo](https://github.com/forrybg/foritech-secure-system)

---

## What’s inside

- `docs/` — investor/technical docs (TRL, SWOT, timelines, security notes, etc.)
- `scripts/` — tiny helper scripts used in demos
- `.github/` — CI for link-checks and templates
- `CHANGELOG.md`, `CODE_OF_CONDUCT.md`, `LICENSE` — meta & governance

> All docs here are **English-only** on purpose (for submissions and external sharing).

---

## Quick start

```bash
git clone https://github.com/forrybg/foritech-investor-demo.git
cd foritech-investor-demo

# (optional) run the link-check locally if you have lychee installed
# lychee --no-progress README.md docs
Then open the docs:

TRL evidence: docs/trl.md

Team: docs/team.md

SWOT: docs/swot.md

More docs: docs/

If you need the product code, go to the core repository:
➡️ [core repo](https://github.com/forrybg/foritech-secure-system)
Roadmap (short)

Finalize investor pack (docs & visuals)

Security hardening checklist (SFTP, Fail2Ban, UFW, TLS) — tracked in the core repo

Grant/seed submissions packaging
Contributing & Community

Security policy: .github/SECURITY.md

Code of Conduct: CODE_OF_CONDUCT.md

Changelog: CHANGELOG.md

License: LICENSE

For issues/requests, please open a GitHub issue.

https://forrybg.github.io/foritech-investor-demo/
