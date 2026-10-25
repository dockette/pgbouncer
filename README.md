<h1 align=center>Dockette / PgBouncer</h1>

<p align=center>
   Docker image for <a href="https://www.pgbouncer.org/">PgBouncer</a>, a connection pooler for PostgreSQL.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
   <a href="https://github.com/dockette/pgbouncer/actions"><img src="https://github.com/dockette/pgbouncer/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/pgbouncer"><img src="https://img.shields.io/docker/pulls/dockette/pgbouncer.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

-----

A thin republish of `dhi.io/pgbouncer` under the `dockette/pgbouncer` name on Docker Hub. Builds use
`FROM dhi.io/pgbouncer:${PGBOUNCER_VERSION}`, so runtime behavior matches that upstream tag.

## Features

- PgBouncer `1.26.0` on the upstream `dhi.io/pgbouncer` image
- Pool port `6432`
- Config and userlist come from mounted files

## Usage

```sh
docker run --name some-pgbouncer -p 6432:6432 \
  -v /path/to/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro \
  dockette/pgbouncer:latest
```

## Configuration

Mount your `pgbouncer.ini` (and an optional userlist) as in the example above. A minimal `pgbouncer.ini`; adjust `host`,
auth and pool names for your setup:

```ini
[databases]
* = host=postgres port=5432

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 6432
auth_type = md5
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = transaction
max_client_conn = 100
default_pool_size = 20
```

## Versions

| Version | Release |
|---------|---------|
| `dockette/pgbouncer:1.26.0-YYYY.MM.DD` | release `YYYY.MM.DD`; pin this one |
| `dockette/pgbouncer:1.26.0` | latest release |
| `dockette/pgbouncer:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/pgbouncer:latest` | latest build of `master` |

All versions build on `dhi.io/pgbouncer:1.26.0`. Releases are listed on [GitHub](https://github.com/dockette/pgbouncer/releases).
A PgBouncer upgrade is a release too.

## Development

```sh
make build          # build the image
make test           # print the PgBouncer version
make run            # run with pgbouncer.ini on port 6432 (PGBOUNCER_CONFIG, PGBOUNCER_USERLIST)
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
