all: precheck check binary package test

.PHONY: check package publish test clean

include ${PROJECTBUILDER}/*/Makefile

precheck:
	@grep -q "PROJECTBUILDER" ${PWD}/Makefile || echo 'include $${PROJECTBUILDER}/Makefile' >> ${PWD}/Makefile
