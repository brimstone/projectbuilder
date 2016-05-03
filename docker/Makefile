ifneq ($(wildcard Dockerfile),)
.PHONY: package publish
package: app
	docker build -t ${DOCKER_TAG} .

publish:
	docker push ${DOCKER_TAG}

endif
