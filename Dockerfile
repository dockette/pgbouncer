ARG PGBOUNCER_VERSION=1.25.1

FROM dhi.io/pgbouncer:${PGBOUNCER_VERSION}

ARG PGBOUNCER_VERSION

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"
LABEL org.opencontainers.image.title="PgBouncer"
LABEL org.opencontainers.image.description="Thin republish of dhi.io/pgbouncer for Dockette"
LABEL org.opencontainers.image.version="${PGBOUNCER_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/dockette/pgbouncer"
