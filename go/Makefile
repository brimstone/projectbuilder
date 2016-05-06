# first, detect our language
ifneq ($(wildcard *.go),)
LANGUAGE ?= go
endif

# second, if this is our language, define checks
ifeq (${LANGUAGE},go)

SETUP ?= go-setup

ifneq ($(wildcard *_test.go),)
CHECK ?= go-fmt go-vet go-lint go-test
else
$(warning == Skipping check step since there are no *_test.go files)
CHECK ?= go-fmt go-vet go-lint
endif

# TODO account for docker
# TODO account for goupx
${BINARY}: *.go
	$(info == Building)
	tar c . | docker run --rm -i -e TAR=1 brimstone/golang-musl \
	-o ${BINARY} \
	| tar x ./app
	#goupx app

CLEAN ?= go-clean

endif


.PHONY: go-setup go-fmt go-vet go-lint go-test
# third, define these anyway, in case the user wants to use them

go-setup:
	go get -u github.com/axw/gocov/gocov
	go get -u github.com/mattn/goveralls
	go get -u github.com/golang/lint/golint
	go get -v -d -u

go-fmt:
	$(info == Formatting code)
	@if [ -n "$(shell gofmt -d -s .)" ]; then \
		gofmt -d -s .; \
		exit 1; \
	fi

go-vet:
	$(info == Vetting code)
	@go tool vet $(shell pwd)

go-lint:
	$(info == Linting code)
	@golint

go-test:
	$(info == Testing code)
	@go test -covermode=count

go-clean:
	$(info == Cleaning)
	-rm ${BINARY}

