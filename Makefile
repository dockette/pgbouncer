DOCKER_IMAGE=dockette/pgbouncer
DOCKER_TAG?=1.25.1
DOCKER_PLATFORMS?=linux/amd64

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg PGBOUNCER_VERSION=${DOCKER_TAG} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test
test:
	docker run --rm --platform ${DOCKER_PLATFORMS} ${DOCKER_IMAGE}:${DOCKER_TAG} pgbouncer --version
