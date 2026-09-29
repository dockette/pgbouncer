DOCKER_IMAGE=dockette/pgbouncer
DOCKER_TAG?=1.26.0
DOCKER_PLATFORMS?=linux/amd64
PGBOUNCER_CONFIG?=pgbouncer.ini
PGBOUNCER_USERLIST?=
PGBOUNCER_USERLIST_VOLUME=$(if $(PGBOUNCER_USERLIST),-v "${PGBOUNCER_USERLIST}:/etc/pgbouncer/userlist.txt:ro")

.DEFAULT_GOAL := help

##@ Help

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_.-]+:.*##/ { sub(/^ +/, "", $$2); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(firstword $(MAKEFILE_LIST))

##@ Docker

.PHONY: build
build: ## Build the image
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg PGBOUNCER_VERSION=${DOCKER_TAG} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test
test: ## Smoke test the image
	docker run --rm --platform ${DOCKER_PLATFORMS} ${DOCKER_IMAGE}:${DOCKER_TAG} pgbouncer --version

.PHONY: run
run: ## Run the image locally (PGBOUNCER_CONFIG=/abs/path/pgbouncer.ini)
	docker run --rm -it --platform ${DOCKER_PLATFORMS} -p 6432:6432 -v "${PGBOUNCER_CONFIG}:/etc/pgbouncer/pgbouncer.ini:ro" ${PGBOUNCER_USERLIST_VOLUME} ${DOCKER_IMAGE}:${DOCKER_TAG}
