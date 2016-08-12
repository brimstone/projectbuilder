GIT_URL ?=
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
ifneq (${GIT_URL},)
PUBLISH ?= git-publish
endif

define VARIABLES_GIT

- GIT_URL = ${GIT_URL}
- GIT_BRANCH = ${GIT_BRANCH}
endef
HELP_VARIABLES += ${VARIABLES_GIT}

git-publish:
	@echo == Publishing with git
	@git remote -v | grep -q "${GIT_URL}" \
	|| git remote add deploy "${GIT_URL}"
	@git push deploy ${GIT_BRANCH}
