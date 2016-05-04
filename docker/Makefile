ifndef PACKAGER
ifneq ($(wildcard Dockerfile),)
PACKAGER=docker
endif
endif

ifeq (${PACKAGER},docker)
ifndef PACKAGE
package: app
	docker build -t ${DOCKER_TAG} .
endif

ifndef PUBLISH
publish:
	docker push ${DOCKER_TAG}
endif

endif
