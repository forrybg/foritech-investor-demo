# Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| PQC standard/impl changes | Medium | High | Track NIST/OQS; keep hybrid mode; modular crypto backends |
| Integration friction (legacy PKI) | Medium | Medium | Provide hybrid X.509/TLS path + docs/examples |
| Performance regressions | Medium | Medium | Measure KPIs; optimize critical paths; caching |
| Security vulnerability | Low | High | Reviews, CI checks, dep scanning; minimal attack surface |
| Funding gap | Medium | Medium | Staged scope; micro-grants pipeline; lean ops |
| Talent bandwidth | Medium | Medium | Focused roadmap; automate; community contributions |
| Regulatory shifts | Low | Medium | Monitor guidance; align with best-practice frameworks |
