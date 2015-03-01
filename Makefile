.PHONY:  json-to-xml clean help api-deps

include Makefile.helpers

PYTHON = python2.7
TPL = etc/bin/pyratemp.py

API_DEPS_TPL = src/pyra/deps.pyra
API_MAIN_TPL = src/pyra/main.pyra
API_DEPS = .api.deps
API_SHARED_INFO = ./etc/api/shared.yaml
API_JSON_FILES = $(shell find ./etc -type f -name '*-api.json')

help:
	$(info Programs)
	$(info ----> templat engine: '$(TPL)')
	$(info )
	$(info Targets)
	$(info help         -   print this help)
	$(info api-deps     -   generate a file to tell make what API file dependencies will be)
	$(info help-api     -   show all api targets to build individually)

$(API_DEPS): $(API_SHARED_INFO) $(API_DEPS_TPL)
	$(TPL) -f $(API_SHARED_INFO) $(API_DEPS_TPL) > $@

api-deps: $(API_DEPS)

include $(API_DEPS)

clean: clean-api
	-rm $(API_DEPS)


