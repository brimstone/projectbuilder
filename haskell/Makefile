# first, detect our language
ifneq ($(wildcard *.hs),)
LANGUAGE ?= haskell
FILES=*.hs
endif

ifneq ($(wildcard stack.yaml),)
LANGUAGE ?= haskell
FILES=
endif

# second, if this is our language, define checks
ifeq (${LANGUAGE},haskell)
LANGUAGE_VERSION ?= 0

SETUP ?=

CHECK ?=

ifeq ($(shell which docker),)
${BINARY}: ${FILES}
	$(info == Building)
	stack ghc -- -static -optl-static -threaded -o ${BINARY} ${FILES}
	strip ${BINARY}
else
${BINARY}: ${FILES}
	$(info == Building)
	tar c . --exclude "${BINARY}" | docker run --rm -i \
		-e TAR=1 \
		brimstone/haskell \
		-o ${BINARY} ${FILES} \
	| tar x "./${BINARY}"
endif

CLEAN ?= haskell-clean

endif


# third, define these anyway, in case the user wants to use them

.PHONY: haskell-clean
haskell-clean:
	$(info == Cleaning)
	-rm -f ${BINARY}
	-rm -f *.dyn_hi *.dyn_o *.hi *.o

