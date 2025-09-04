# Backup & Restore

## Quick diagnostics

- List tracked archives
- Verify integrity (hash)
- Check last snapshot time

## Snapshot backup (local, out-of-git)

- `repo-tracked.tar.gz` — current repo state (tracked files only)
- `pki.tar.gz` — PKI DB (public materials)
- `foritech-keys.tar.gz` — **never commit**; offsite only

```bash
# example
./scripts/pki_init_db.sh

Offsite

Push archives to object storage (MinIO/S3)

Restore (example)

Extract archives, then reinit PKI DB, restart services
