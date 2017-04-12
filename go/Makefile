# first, detect our language
ifneq ($(wildcard *.go),)
LANGUAGE ?= go
LANGUAGE_VERSION ?= 1.6
endif

# second, if this is our language, define checks
ifeq (${LANGUAGE},go)

SETUP ?= go-setup

CHECK ?= go-fmt go-vet go-lint go-generate

ifneq ($(wildcard *_test.go),)

ifneq (${COVERALLS},)
CHECK += go-coveralls
else
CHECK += go-test
endif

else
$(info == Skipping tests in check step since there are no *_test.go files)
endif

export LDFLAGS=-X main.GitCommit=${GITCOMMIT} \
-X main.GitBranch=${GITBRANCH} \
-X main.GitState=${GITSTATE} \
-X main.GitSummary=${GITSUMMARY} \
-X main.BuildDate=${BUILDDATETIME} \
$(foreach var,${BUILDVARS},-X main.${var})

ifeq (${DOCKER},)
${BINARY}: precheck check *.go
	go build -ldflags "-linkmode external -extldflags \"-static\" -s -w ${LDFLAGS}" -i -o ${BINARY}
else
${BINARY}: precheck check *.go
	$(info == Building)
	tar c . --exclude "${BINARY}" | ${DOCKER} run --rm -i \
		-e TAR=1 \
		-e LDFLAGS \
		brimstone/golang-musl \
		-o ${BINARY} \
	| tar x "./${BINARY}"
endif

CLEAN ?= go-clean

endif


# third, define these anyway, in case the user wants to use them
.PHONY: go-setup
go-setup:
	go get -u github.com/axw/gocov/gocov
	go get -u github.com/mattn/goveralls
	go get -u github.com/golang/lint/golint
	go get -v -d -u

.PHONY: go-fmt
go-fmt:
	$(info == Formatting code)
	@if [ -n "$(shell gofmt -d -s .)" ]; then \
		gofmt -d -s .; \
		exit 1; \
	fi

.PHONY: go-vet
go-vet:
	$(info == Vetting code)
	@go tool vet $(shell pwd)

.PHONY: go-lint
go-lint:
	$(info == Linting code)
	@golint

.PHONY: go-generate
go-generate:
	$(info == Generating code)
	@go generate

.PHONY: go-coveralls
go-coveralls:
	$(info == Submitting coveralls report)
	@goveralls -v -repotoken ${COVERALLS}

.PHONY: go-test
go-test:
	$(info == Testing code)
	@go test -covermode=count

.PHONY: go-clean
go-clean:
	$(info == Cleaning)
	-rm ${BINARY}
