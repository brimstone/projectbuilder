.PHONY: travis travis.yaml

travis: travis.yml setup all publish

define newline


endef

define TRAVIS_SCRIPT
script:
  - git clone https://github.com/brimstone/projectbuilder
  - export PROJECTBUILDER=\$$PWD/projectbuilder
  - make travis
endef

define TRAVIS_SERVICES
services:
  - docker
endef

travis.yml:
	clear
	@[ -f .travis.yaml ] || touch .travis.yml

	@grep -zqP "language: ${LANGUAGE}" .travis.yml \
	|| (sed -i -z "s/language:[^\n]*//g" .travis.yml \
	&& echo "language: ${LANGUAGE}" >> .travis.yml \
	&& echo "" >> .travis.yml)

	@grep -zq "$(subst $(newline),\n,${TRAVIS_SERVICES})" .travis.yml \
	|| (sed -i -z "s/services:\(\n[^\n]*\)*//g" .travis.yml \
	&& echo -e "$(subst $(newline),\n,${TRAVIS_SERVICES})" >> .travis.yml \
	&& echo "" >> .travis.yml)

	@grep -zq "$(subst $(newline),\n,${TRAVIS_SCRIPT})" .travis.yml \
	|| (sed -i -z "s/script:\(\n[^\n]*\)*//g" .travis.yml \
	&& echo -e "$(subst $(newline),\n,${TRAVIS_SCRIPT})" >> .travis.yml \
	&& echo "" >> .travis.yml)
