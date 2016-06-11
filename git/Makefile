ifneq (${GIT_URL},)
PUBLISH ?= git-publish
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
endif

git-publish:
	@echo == Publishing with git
	@git remote -v | grep -q "${GIT_URL}" \
	|| git remote add deploy "${GIT_URL}"
	@git push deploy ${GIT_BRANCH}
