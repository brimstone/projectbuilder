all: precheck check binary package test

.PHONY: check package publish test clean

PRECHECK = main-precheck

include ${PROJECTBUILDER}/*/Makefile

precheck: ${PRECHECK}

main-precheck:
	if tail -n 1 ${PWD}/Makefile | !grep -q "PROJECTBUILDER"; then \
		sed -i '/PROJECTBUILDER/d' ${PWD}/Makefile; \
		echo 'include $${PROJECTBUILDER}/Makefile' >> ${PWD}/Makefile; \
	fi

check: ${CHECK}

binary: ${BINARY}

package: ${PACKAGE}

test: ${TEST}

publish: ${PUBLISH}
