define DOCKERFILE
FROM scratch

COPY ${BINARY} /

ENTRYPOINT [\"/${BINARY}\"]
endef

DOCKER_PASSWORD ?=
DOCKER_LOGIN ?=
# try to set an org from our logged in user, if it's not already set
DOCKER_ORG ?= $(shell awk -F '"' '$$2 == "auth" {print $$4; exit}' \
					~/.docker/config.json \
				| base64 -d \
				| awk -F: '{print $$1}')
# if we still don't have an org, don't set a tag
ifeq (${DOCKER_ORG},)
DOCKER_TAG ?=
else
DOCKER_TAG ?= ${DOCKER_ORG}/$(notdir ${PWD})
endif # DOCKER_ORG

ifeq ($(shell echo "${DOCKER_TAG}" | sed 's/[^/]//g'),//)
DOCKER_REGISTRY ?= $(shell echo "${DOCKER_TAG}" | sed 's/\/.*//')
else
DOCKER_REGISTRY ?= https://index.docker.io/v1/
endif

define HELP_DOCKER

- Docker
  - Dockerfile
      Output a sample Dockerfile
endef

HELP_TARGETS += ${HELP_DOCKER}


# if we have a dockerfile and docker installed
ifneq ($(wildcard Dockerfile),)
ifneq (${DOCKER},)

# assume we should be a docker package
PACKAGE = docker-package

# if we don't have an auth file, assume we're not logged in to publish
ifeq ($(wildcard ${HOME}/.docker/config.json),)
# if DOCKER_PASSWORD isn't set, then we can't even login
ifneq ($(DOCKER_PASSWORD),)
DOCKER_LOGIN = $(shell ${DOCKER} login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" "${DOCKER_REGISTRY}" </dev/null 2>&1)
$(info == Results of Docker Login: ${DOCKER_LOGIN})
endif
endif # wildcard config.json

# if we still don't have a tag set, don't publish with docker
ifeq ($(DOCKER_TAG),)
$(warning == Docker detected, but unable to determine $$DOCKER_ORG and $$DOCKER_TAG is empty. Not publishing with docker.)
else
PUBLISH = docker-publish
endif # DOCKER_TAG

endif # shell which docker
endif # wildcard Dockerfile

define VARIABLES_DOCKER

- DOCKER_LOGIN = ${DOCKER_LOGIN}
- DOCKER_PASSWORD = <hidden>
- DOCKER_ORG = ${DOCKER_ORG}
- DOCKER_TAG = ${DOCKER_TAG}
endef

HELP_VARIABLES += ${VARIABLES_DOCKER}

docker-package: ${BINARY}
	$(info == Building Docker image)
	${DOCKER} build \
	-t ${DOCKER_TAG} \
	--label org.label-schema.schema-version="1.0" \
	--label org.label-schema.build-date="$(BUILDDATETIME)" \
	--label org.label-schema.vcs-ref="${GITCOMMIT}" \
	--label org.label-schema.version="${GITSUMMARY}" \
	.
	${DOCKER} tag ${DOCKER_TAG} ${DOCKER_TAG}:${GITSUMMARY}

docker-publish:
	$(info == Pushing Docker image)
	docker push ${DOCKER_TAG}

Dockerfile:
	@echo -e "$(subst $(newline),\n,${DOCKERFILE})" > Dockerfile
