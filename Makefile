SHELL := /bin/bash
VENV := .venv
PY := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

default: help
help:
	@echo "Targets:"
	@echo "  venv        - create .venv"
	@echo "  install     - pip install -e ../foritech-secure-system"
	@echo "  oqs         - build/install liboqs + oqs (if script exists)"
	@echo "  certs-copy  - copy server cert/key from sibling repo"
	@echo "  server      - run TLS-PQC server (needs FORITECH_SK)"
	@echo "  client      - run TLS-PQC client"
	@echo "  wrap        - wrap demo file (uses kyber768_pub.bin)"
	@echo "  unwrap      - unwrap and diff"
	@echo "  demo        - wrap + unwrap"
	@echo "  clean       - remove demo artifacts"

venv:
	python3 -m venv $(VENV)

install: venv
	$(PIP) install -e ../foritech-secure-system

oqs: venv
	@if [[ -x ../foritech-secure-system/scripts/dev_install_oqs.sh ]]; then \
		bash ../foritech-secure-system/scripts/dev_install_oqs.sh; \
	else \
		echo "No dev_install_oqs.sh found. Skip."; \
	fi

certs-copy:
	mkdir -p certs
	cp ../foritech-secure-system/pki/issued/leaf-sub1_fullchain.pem certs/server_cert.pem
	cp ../foritech-secure-system/pki/issued/leaf-sub1.key         certs/server_key.pem
	@echo "certs/ ready"

server:
	@if [[ -z "$$FORITECH_SK" ]] ; then echo "Set FORITECH_SK to your Kyber secret (e.g. $$HOME/.foritech/keys/kyber768_sec.bin)"; exit 2; fi
	$(PY) ../foritech-secure-system/scripts/tls_pqc_server.py --host 0.0.0.0 --port 8443 --cert certs/server_cert.pem --key certs/server_key.pem --kyber-sk "$$FORITECH_SK"

client:
	$(PY) ../foritech-secure-system/scripts/tls_pqc_client.py --host 127.0.0.1 --port 8443

wrap:
	echo "hi" > s.txt
	$(VENV)/bin/foritech wrap --in s.txt --out s.enc --recipient raw:$$HOME/.foritech/keys/kyber768_pub.bin --kid demo

unwrap:
	$(VENV)/bin/foritech unwrap --in s.enc --out s.out
	diff -u s.txt s.out && echo "OK ✅"

demo: wrap unwrap

clean:
	rm -f s.txt s.enc s.out

.PHONY: doctor
doctor:
	@bash scripts/doctor.sh
