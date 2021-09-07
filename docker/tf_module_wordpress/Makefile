.ONESHELL:
.SHELL := /usr/bin/bash
terraform := $(shell command -v terraform 2> /dev/null)
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

set-env:
	@if [ -z $(ENV) ]; then \
		echo "$(BOLD)$(RED)ENV was not set$(RESET)"; \
		exit 1; \
	fi

	@if [ ! -d "creds" ]; then \
		mkdirs -p creds \
	fi

	@if [ ! -f "creds/service_accound_$(ENV).json" ]; then \
		echo "$(BOLD)$(RED)Credential file is missing$(RESET)"; \
		exit 1; \
	fi

tfvars: set-env
	$(eval varFiles=$(shell sh -c "find environments/$(ENV) -maxdepth 1 -name '*.tfvars'" | awk '{print "-var-file="$$0}' | perl -pe 'eof||s|$/| |'))

backend: set-env
	$(eval backend=$(shell sh -c "find environments/$(ENV) -maxdepth 1 -name '*.hcl'"))

init: set-env backend
	@terraform init -backend-config=$(backend)

plan: set-env tfvars
	@terraform plan $(varFiles) -out $(ENV).tfplan -input=false -lock=false

apply:
	@terraform apply -input=false -lock=false $(ENV).tfplan

clean: tfvars
	rm -f $(ENV).tfplan
