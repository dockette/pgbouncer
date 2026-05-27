DOCKER_IMAGE=dockette/pgbouncer
DOCKER_TAG?=1.25.1
DOCKER_PLATFORMS?=linux/amd64
PGBOUNCER_CONFIG?=pgbouncer.ini
PGBOUNCER_USERLIST?=
PGBOUNCER_USERLIST_VOLUME=$(if $(PGBOUNCER_USERLIST),-v "${PGBOUNCER_USERLIST}:/etc/pgbouncer/userlist.txt:ro")

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg PGBOUNCER_VERSION=${DOCKER_TAG} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test
test:
	docker run --rm --platform ${DOCKER_PLATFORMS} ${DOCKER_IMAGE}:${DOCKER_TAG} pgbouncer --version

.PHONY: run
run:
	docker run --rm -it --platform ${DOCKER_PLATFORMS} -p 6432:6432 -v "${PGBOUNCER_CONFIG}:/etc/pgbouncer/pgbouncer.ini:ro" ${PGBOUNCER_USERLIST_VOLUME} ${DOCKER_IMAGE}:${DOCKER_TAG}
