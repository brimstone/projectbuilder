# http://clarkgrubb.com/makefile-style-guide

## Prologue
# Boilerplate variables
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# our global, user callable targets
.PHONY: check package test publish clean
# our usually not user callable targets
.PHONY: setup precheck main-precheck
# our variables with sane defaults
PRECHECK = main-precheck
BINARY ?= app
BINARIES ?=
TEST ?=
PACKAGE ?=
PUBLISH ?=
COVERALLS ?=
HELP_TARGETS ?=
HELP_VARIABLES ?=
DOCKER ?= $(shell which docker)
define newline


endef

COMMITHASH := $(shell git describe --always --tags --dirty)
BUILDDATETIME := $(shell date --utc --iso-8601=seconds)

## targets
all: precheck check binaries package test

include ${PROJECTBUILDER}/*/Makefile

setup: ${SETUP}

precheck: ${PRECHECK}

main-precheck:
	$(info == Precheck)
	@[ -e "${PWD}/Makefile" ] || touch "${PWD}/Makefile"
	@if ! tail -n 1 ${PWD}/Makefile | grep -q "PROJECTBUILDER"; then \
		sed -i '/PROJECTBUILDER/d' ${PWD}/Makefile; \
		echo 'include $${PROJECTBUILDER}/Makefile' >> ${PWD}/Makefile; \
	fi

check: ${CHECK}

binary: ${BINARY}

binaries: binary ${BINARIES}

package: ${PACKAGE}

test: ${TEST}

clean: ${CLEAN}
	-rm ${BINARIES}

publish: ${PUBLISH}

define HELPTEXT
Projectbuilder Help

Detected language: ${LANGUAGE} version ${LANGUAGE_VERSION}
Binary name: ${BINARY}
Binaries to be built: ${BINARY} ${BINARIES}


Configurable Variables:
Configure these variables in the project Makefile or environment.
${HELP_VARIABLES}
- COVERALLS = ${COVERALLS}


Common targets:
These are available to every project

 - precheck: ${PRECHECK}
     Verify the environment is ready for use.
     It's common to make sure the system has the right languages or libraries
     installed at this step.
 - check: ${CHECK}
     Verify the code is ready for compilation.
     It's common to run unit tests at this step.
 - ${BINARY}
     Just build our main binary.
 - binaries: ${BINARY} ${BINARIES}
     Build our main binary and any other binaries related to this project.
 - package: ${PACKAGE}
     Package the binary(es) into a single artifact.
     It's common for system package or container packaging to take place at this
     stage.
 - test: ${TEST}
     Test the packaging.
     This is really only used for containers, but could be used for system
     packaging too.
 - clean: ${CLEAN}
     Cleans the working directory from any artifacts generated from any above steps
 - publish: ${PUBLISH}
     Publishes the packaged artifact to somewhere.


Specific targets:
${HELP_TARGETS}

endef

.PHONY: help
help:
	@echo -e "$(subst $(newline),\n,${HELPTEXT})"

Makefile:
	@echo -e "$(subst $(newline),\n,${HELP_VARIABLES})" | sed 's/^/#/g' > Makefile
	@${PROJECTBUILDER}/make precheck
