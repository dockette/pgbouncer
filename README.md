<h1 align=center>Dockette / PgBouncer</h1>

<p align=center>
   <a href="https://github.com/dockette/pgbouncer/actions"><img src="https://github.com/dockette/pgbouncer/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/pgbouncer"><img src="https://img.shields.io/docker/pulls/dockette/pgbouncer.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   <a href="https://www.pgbouncer.org/">PgBouncer</a>, the connection pooler for PostgreSQL, in a Docker image. It is a thin republish of <code>dhi.io/pgbouncer</code> under the <code>dockette/pgbouncer</code> name, for anyone who runs a connection pool in front of PostgreSQL.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

## Usage

Run PgBouncer on port `6432` with your own `pgbouncer.ini` from the current folder:

```sh
docker run --name some-pgbouncer -p 6432:6432 \
  -v "$(pwd)/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro" \
  dockette/pgbouncer:1.26.0
```

Based on `dhi.io/pgbouncer:1.26.0`, with no changes on top: the image adds no entrypoint, no default config and no
environment variables. You configure it with a mounted `pgbouncer.ini` and, when it uses `auth_file`, a mounted
`userlist.txt`. `linux/amd64` only.

A minimal `pgbouncer.ini` looks like this. Adjust `host`, the auth settings and the pool sizes for your database:

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

The config above reads users from `auth_file`. Mount your userlist next to the config:

```sh
docker run --name some-pgbouncer -p 6432:6432 \
  -v "$(pwd)/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro" \
  -v "$(pwd)/userlist.txt:/etc/pgbouncer/userlist.txt:ro" \
  dockette/pgbouncer:1.26.0
```

See the [PgBouncer configuration reference](https://www.pgbouncer.org/config.html) for all settings.

## Versions

| Tag | Upstream |
|-----|----------|
| `dockette/pgbouncer:1.26.0` | `dhi.io/pgbouncer:1.26.0` |
| `dockette/pgbouncer:latest` | Same as `1.26.0` |

Older version tags stay on [Docker Hub](https://hub.docker.com/r/dockette/pgbouncer/tags) unchanged, so you can pin
them.

## Development

```sh
make build   # build the image
make test    # smoke test it
make run     # run it locally
```

Run `make` to list every target.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider [supporting](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
