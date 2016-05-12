.PHONY: travis travis.yaml

travis: setup all publish

define newline


endef

define TRAVIS_YML
language: ${LANGUAGE}

${LANGUAGE}:
  - ${LANGUAGE_VERSION}

services:
  - docker

script:
  - git clone https://github.com/brimstone/projectbuilder
  - export PROJECTBUILDER=\$$PWD/projectbuilder
  - make travis
endef

travis.yml:
	@[ -f .travis.yaml ] || touch .travis.yml

	@if [ "$(shell echo -e "$(subst $(newline),\n,${TRAVIS_YML})" | md5sum)" \
		!= "$(shell md5sum < .travis.yml)" ] ; then \
		echo == Correcting .travis.yml file; \
		echo -e "$(subst $(newline),\n,${TRAVIS_YML})" > .travis.yml; \
	fi
