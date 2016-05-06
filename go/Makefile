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

ifneq (${COVERALLS},)
CHECK = ${CHECK} go-coveralls
endif

ifeq ($(shell which docker),)
${BINARY}: *.go
	go build -i -o ${BINARY}
else
${BINARY}: *.go
	$(info == Building)
	tar c . | docker run --rm -i -e TAR=1 brimstone/golang-musl \
	-o ${BINARY} \
	| tar x ./app
endif

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

go-coveralls:
	$(info == Submitting coveralls report)
	@goveralls -v -repotoken ${COVERALLS}

go-test:
	$(info == Testing code)
	@go test -covermode=count

go-clean:
	$(info == Cleaning)
	-rm ${BINARY}

