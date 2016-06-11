.PHONY: travis travis.yaml

# If we have our key, decrypt things before we get going
ifneq (${TRAVIS_TAR_KEY},)
TRAVIS = travis-decrypt
endif

# default travis bits
TRAVIS += setup all

# if this is the master branch, also publish
ifeq (${TRAVIS_BRANCH},master)
TRAVIS += travis-publish
endif

travis: ${TRAVIS}

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

# sets up travis yaml file
travis.yml:
	@[ -f .travis.yaml ] || touch .travis.yml

	@if [ "$(shell echo -e "$(subst $(newline),\n,${TRAVIS_YML})" | md5sum)" \
		!= "$(shell md5sum < .travis.yml)" ] ; then \
		echo == Correcting .travis.yml file; \
		echo -e "$(subst $(newline),\n,${TRAVIS_YML})" > .travis.yml; \
	fi

# for setting up the ssh key on our side
.PHONY: travis-gitignore
travis-gitignore:
	@grep -q '^.travis$$' .gitignore || echo '.travis' >> .gitignore
	@grep -q '^.travis.tar$$' .gitignore || echo '.travis.tar' >> .gitignore

.PHONY: .travis
.travis:
	@mkdir -p .travis

.travis/id_rsa: .travis travis-gitignore
	@[ -f .travis/id_rsa ] || echo "n" | ssh-keygen -b 4096 -t rsa -N "" -f .travis/id_rsa

.travis.tar.enc: .travis/id_rsa
	@tar -zcf .travis.tar .travis
	@key="$$(openssl rand -base64 30)"; \
	openssl enc -aes-256-cbc -pass "pass:$$key" < .travis.tar > .travis.tar.enc; \
	travis env set TRAVIS_TAR_KEY "$$key" -p

# what the user calls
travis-ssh: .travis.tar.enc
	@printf "Travis's pub key: "
	@cat .travis/id_rsa.pub

# what travis calls to decrypt the key

.PHONY: travis-decrypt
travis-decrypt:
	@echo "== Decrypting .travis"
	@openssl enc -aes-256-cbc -pass "pass:${TRAVIS_TAR_KEY}" -d < .travis.tar.enc | tar -zx
	@printf 'Host *\n\tStrictHostKeyChecking no\n' >> ~/.ssh/config
	@echo "== Starting ssh-agent"
	@eval $$(ssh-agent -s); \
	echo "$$SSH_AUTH_SOCK" > .travis/ssh_auth_sock; \
	echo "$$SSH_AGENT_PID" > .travis/ssh_agent_pid; \
	echo "== Adding key to agent"; \
	ssh-add .travis/id_rsa

.PHONY: travis-publish
travis-publish:
	# shim our ssh_auth_sock if we have it
	@if [ -f .travis/ssh_auth_sock ]; then \
		export SSH_AUTH_SOCK=$$(< .travis/ssh_auth_sock); \
		$(MAKE) publish; \
	else \
		$(MAKE) publish; \
	fi
