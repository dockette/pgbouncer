<h1 align=center>Dockette / PgBouncer</h1>

<p align=center>
   Minimal Docker image for <a href="https://www.pgbouncer.org/">PgBouncer</a>, a connection pooler for PostgreSQL. This tag mirrors <code>dhi.io/pgbouncer</code> under the <code>dockette/pgbouncer</code> name on Docker Hub.
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

## Usage

Mount your `pgbouncer.ini` (and optional userlist) and expose the pool port (default **6432**):

```sh
docker run --name some-pgbouncer -p 6432:6432 \
  -v /path/to/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro \
  dockette/pgbouncer:1.26.0
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

`dhi.io/pgbouncer:1.26.0` is the upstream image. Tags on [Docker Hub](https://hub.docker.com/r/dockette/pgbouncer/tags/):

| Tag | What it is |
|-----|------------|
| `dockette/pgbouncer:latest` | latest build of `master` |
| `dockette/pgbouncer:2026.10.23` | release `2026.10.23` |
| `dockette/pgbouncer:1.26.0` | latest build with PgBouncer `1.26.0` |
| `dockette/pgbouncer:1.26.0-2026.10.23` | PgBouncer `1.26.0` in release `2026.10.23`; pin this one |

The image is a thin republish: builds use `FROM dhi.io/pgbouncer:${PGBOUNCER_VERSION}` so runtime behavior matches that upstream tag.

The release version is the date in [`VERSION`](VERSION). The PgBouncer version is pinned in the workflow (`PGBOUNCER_VERSION`). On `master`, CI pushes the `latest` image under the four tags above.
To release, run `make release`, commit and push to `master`. A PgBouncer upgrade is a release too.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
