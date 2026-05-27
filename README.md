<h1 align=center>Dockette / PgBouncer</h1>

<p align=center>
   Minimal Docker image for <a href="https://www.pgbouncer.org/">PgBouncer</a>, a connection pooler for PostgreSQL. This tag mirrors <code>dhi.io/pgbouncer</code> under the <code>dockette/pgbouncer</code> name on Docker Hub.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://github.com/dockette/pgbouncer/actions/workflows/docker.yml"><img src="https://github.com/dockette/pgbouncer/actions/workflows/docker.yml/badge.svg"></a>
  <a href="https://hub.docker.com/r/dockette/pgbouncer/"><img src="https://badgen.net/docker/pulls/dockette/pgbouncer"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
  <a href="https://github.com/orgs/dockette/discussions"><img src="https://badgen.net/badge/support/discussions/cyan"></a>
</p>

-----

## Usage

Mount your `pgbouncer.ini` (and optional userlist) and expose the pool port (default **6432**):

```sh
docker run --name some-pgbouncer -p 6432:6432 \
  -v /path/to/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro \
  dockette/pgbouncer:1.25.1
```

Minimal `pgbouncer.ini` sketch (adjust `host`, auth, and pool names for your setup):

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

| Image tag | Equivalent upstream | Docker Hub |
|-----------|---------------------|------------|
| `dockette/pgbouncer:1.25.1` | `dhi.io/pgbouncer:1.25.1` | [tags](https://hub.docker.com/r/dockette/pgbouncer/tags/) |
| `dockette/pgbouncer:latest` | same as `1.25.1` (rolling) | [tags](https://hub.docker.com/r/dockette/pgbouncer/tags/) |

The image is a thin republish: builds use `FROM dhi.io/pgbouncer:${PGBOUNCER_VERSION}` so runtime behavior matches that upstream tag.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
