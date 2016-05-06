ifneq ($(wildcard Dockerfile),)
ifneq ($(shell which docker),)

PACKAGE ?= docker-package

ifeq (${DOCKER_TAG},)
DOCKER_ORG ?= $(shell awk -F '"' '$$2 == "auth" {print $$4; exit}' \
					~/.docker/config.json \
				| base64 -d \
				| awk -F: '{print $$1}')
ifeq (${DOCKER_ORG},)
$(warning == Docker detected, but unable to determine $$DOCKER_ORG and $$DOCKER_TAG is empty. Not publishing with docker.)
else
DOCKER_TAG ?= ${DOCKER_ORG}/$(notdir ${PWD})
endif # DOCKER_ORG

endif # DOCKER_TAG

ifneq (${DOCKER_TAG},)
PUBLISH ?= docker-publish
endif # DOCKER_TAG

endif # shell which docker
endif # wildcard Dockerfile

docker-package: ${BINARY}
	$(info == Building Docker image)
	docker build -t ${DOCKER_TAG} .

docker-publish:
	$(info == Pushing Docker image)
	docker push ${DOCKER_TAG}
