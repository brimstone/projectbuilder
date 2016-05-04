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
check: go-test
else
check:
	@echo "=> Skipping check step since there are no *_test.go files"
endif
endif

ifndef BINARY
binary: app
endif

ifndef APP
app: *.go
	tar c . | docker run --rm -i -e TAR=1 brimstone/golang-musl \
	-o app -ldflags '-linkmode external -extldflags "-static" -s -w' \
	| tar x ./app
	goupx app
endif

endif


# third, define these anyway, in case the user wants to use them
go-test:
	@go test

