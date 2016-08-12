# first, detect our language
ifneq ($(wildcard *.hs),)
LANGUAGE ?= haskell
# TODO LANGUAGE_VERSION ?= 1.6
endif

# second, if this is our language, define checks
ifeq (${LANGUAGE},haskell)

${BINARY}: *.hs
	$(info == Building)
	stack ghc -- -static -optl-static -threaded -o ${BINARY} *.hs
	strip ${BINARY}

CLEAN ?= haskell-clean

endif


# third, define these anyway, in case the user wants to use them

.PHONY: haskell-clean
haskell-clean:
	$(info == Cleaning)
	-rm -f ${BINARY}
	-rm -f *.dyn_hi *.dyn_o *.hi *.o

