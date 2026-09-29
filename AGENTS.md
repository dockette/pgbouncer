# Dockette / PgBouncer

PgBouncer connection pooler for PostgreSQL, republished from the upstream hardened image.

## Stack

- Docker image built with `docker buildx`, base `dhi.io/pgbouncer`
- PgBouncer 1.26.0
- Published to Docker Hub as `dockette/pgbouncer` for linux/amd64 by GitHub Actions

## Development

```bash
make build       # build the image
make test        # smoke test the image
make run         # run it locally on port 6432 (PGBOUNCER_CONFIG=pgbouncer.ini)
```

`make build DOCKER_TAG=1.26.0` builds one PgBouncer version.

## Principles

- KISS: one image does one job; no extra services or tools.
- DRY: shared steps live in the base image, not copied into every Dockerfile.
- YAGNI: add a package only when the image needs it.
- Pin versions, keep layers small, clean package caches in the same `RUN`.
- Every change is built and smoke tested with `make build test` before a commit.
