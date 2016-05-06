ifneq ($(wildcard Dockerfile),)
ifneq ($(shell which docker),)

PACKAGE ?= docker-package

ifneq ($(shell grep auths ~/.docker/config.json),)
PUBLISH ?= docker-publish
endif

endif
endif

docker-package: ${BINARY}
	$(info == Building Docker image)
	docker build -t ${DOCKER_TAG} .

docker-publish:
	$(info == Pushing Docker image)
	docker push ${DOCKER_TAG}
