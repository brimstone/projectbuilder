ifneq ($(wildcard *.go),)
ifneq ($(wildcard *_test.go),)
check:
	@go test
else
check:
	@echo "Skipping check step since there are no *_test.go files"
endif

binary: app

app: *.go
	tar c . | docker run --rm -i -e TAR=1 brimstone/golang-musl \
	-o app -ldflags '-linkmode external -extldflags "-static" -s -w' \
	| tar x ./app
	goupx app

endif
