# Architecture
Components (SDK/CLI, Crypto, TLS/X.509, Ops), Flows (wrap/KEM/TLS), Metrics (throughput, integrity, MTTR).

## Demo KPIs we will report
- TLS-PQC handshake success ≥ 99%
- Cert issue/verify < 0.5 s (local)
- Handshake latency < 150 ms (local)
- CI pass rate 100%, 0 broken links
flowchart LR
    U[User/Client] -->|ZK Auth (SSI DID)| G[Gateway]
    G -->|TLS-PQC (Hybrid X.509)| S[Service/API]
    S -->|PKI| CA[(PQC/Hybrid CA)]
    S -->|Ops| LOG[Audit/Logs]

Demo KPIs we will report

TLS-PQC handshake success ≥ 99%

Cert issue/verify < 0.5 s (local)

Handshake latency < 150 ms (local)

CI pass rate 100%, 0 broken links
