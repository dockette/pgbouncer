# Dockette / PgBouncer

Instructions for AI coding agents working in this repository.

## Overview

`dockette/pgbouncer` republishes `dhi.io/pgbouncer` under the Dockette name on Docker Hub. It is a thin
republish (see IMAGES.md): the `Dockerfile` only sets `ARG`, `FROM` and labels. It adds no config, no
entrypoint and no environment variables, so runtime behaviour must match the upstream tag.

- **Image**: `dockette/pgbouncer`, tags `1.26.0` and `latest` (same image)
- **Base**: `dhi.io/pgbouncer:${PGBOUNCER_VERSION}`, default `1.26.0`
- **Platforms**: `linux/amd64`

## Documentation

- `README.md` is also the Docker Hub description; the `docs` job publishes it from `master`.
- Organization rules are in [dockette/dockette specs](https://github.com/dockette/dockette/tree/master/specs).

## Commands

```bash
# Build the image for the default tag (1.26.0); DOCKER_TAG=<upstream tag> builds another version
make build

# Smoke test (pgbouncer --version)
make test

# Run on port 6432 with a local config, optionally with a userlist
make run PGBOUNCER_CONFIG=$(pwd)/pgbouncer.ini
make run PGBOUNCER_CONFIG=$(pwd)/pgbouncer.ini PGBOUNCER_USERLIST=$(pwd)/userlist.txt
```

CI does not call `make`. The `test` job builds with `docker/build-push-action` (tag `-test`, `load: true`) and
runs `pgbouncer --version`; the `build` job pushes `1.26.0` and `latest` from `master` only.

## Conventions

- The image tag is the upstream version. `DOCKER_TAG` is passed to the build as `PGBOUNCER_VERSION`.
- Labels follow IMAGES.md; `org.opencontainers.image.version` comes from `PGBOUNCER_VERSION`.
- The `Dockerfile` holds only `ARG`, `FROM` and `LABEL`. Anything more makes it a build image, not a
  republish.

## Traps

- **A version bump touches four places:** `DOCKER_TAG` in the `Makefile`, `PGBOUNCER_VERSION` in the workflow
  `env`, the `Dockerfile` default `ARG` and the README Versions table. Missing one publishes a tag that the
  README doesn't list.
- **The Makefile has no `help` and no `push` target.** Plain `make` runs `build`, because it is the first
  target. Pushing happens only in CI.
- **CI smoke test and `make test` are separate copies.** The workflow runs its own `docker run ... pgbouncer
  --version`; a change to `make test` does not reach CI, so update both.
- **`PGBOUNCER_CONFIG` must be an absolute path.** Its default `pgbouncer.ini` is relative, so Docker reads it
  as a named volume and mounts an empty directory instead of the file.
- **The weekly rebuild pulls the same pinned upstream tag.** A new upstream release is not picked up on its
  own; bump the version.
- **Old version tags stay on Docker Hub.** Don't delete them after a bump; users pin them (IMAGES.md, Tag
  Naming).
- **`linux/arm64` is not built.** Both workflow jobs set `platforms: linux/amd64`. Check that upstream
  publishes `arm64` before adding it there and to `DOCKER_PLATFORMS`.
- Usage for image users (config file, port, userlist) lives in `README.md`, not here.
