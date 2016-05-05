# first, detect our language
ifndef LANGUAGE
ifneq ($(wildcard *.go),)
LANGUAGE = go
endif
endif

# second, if this is our language, define checks
ifeq (${LANGUAGE},go)

ifndef CHECK
ifneq ($(wildcard *_test.go),)
check: go-fmt go-vet go-lint go-test
else
$(warning "Skipping check step since there are no *_test.go files")
check: go-fmt go-vet go-lint
endif
endif

ifndef BINARY
binary: app
endif

ifndef APP
# TODO account for docker
# TODO account for goupx
app: *.go
	$(info == Building)
	tar c . | docker run --rm -i -e TAR=1 brimstone/golang-musl \
	-o app -ldflags '-linkmode external -extldflags "-static" -s -w' \
	| tar x ./app
	#goupx app
endif

ifndef CLEAN
clean:
	$(info == Cleaning)
	-rm app
endif

endif


.PHONY: go-fmt go-vet go-lint go-test
# third, define these anyway, in case the user wants to use them
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

