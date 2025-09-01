PY ?= .venv/bin/python
HOST ?= 127.0.0.1
PORT ?= 8443

server:
	$(PY) ../foritech-secure-system/scripts/tls_pqc_server.py --host 0.0.0.0 --port $(PORT) --cert certs/server_cert.pem --key certs/server_key.pem --kyber-sk "$$FORITECH_SK"

client:
	$(PY) ../foritech-secure-system/scripts/tls_pqc_client.py --host $(HOST) --port $(PORT)

doctor:
	@./scripts/doctor.sh

.PHONY: server client doctor
