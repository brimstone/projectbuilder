all: check binary package test

.PHONY: check package publish test

include ${PROJECTBUILDER}/*/Makefile
