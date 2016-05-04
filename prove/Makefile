ifndef TESTER
ifneq ($(wildcard t),)
TESTER=prove
endif
endif


ifeq (${TESTER},prove)

ifndef TEST
test:
	@prove
endif

endif
