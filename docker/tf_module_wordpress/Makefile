.ONESHELL:
.SHELL := /usr/bin/bash
terraform := $(shell command -v terraform 2> /dev/null)
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

help: ## Help Section
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
	printf "%-30s %s\n" "target" "help" ; \
	printf "%-30s %s\n" "------" "----" ; \
	for help_line in $${help_lines[@]}; do \
		IFS=$$':' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf '\033[36m'; \
		printf "%-30s %s" $$help_command ; \
		printf '\033[0m'; \
		printf "%s\n" $$help_info; \
	done

set-env: ## Validate all required parameters
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

tfvars: set-env  ## Find and store all tfvars file
	$(eval varFiles=$(shell sh -c "find environments/$(ENV) -maxdepth 1 -name '*.tfvars'" | awk '{print "-var-file="$$0}' | perl -pe 'eof||s|$/| |'))

backend: set-env  ## Find backend file
	$(eval backend=$(shell sh -c "find environments/$(ENV) -maxdepth 1 -name '*.hcl'"))

init: set-env backend  ## Initialize a working directory
	@terraform init -backend-config=$(backend)

plan: set-env tfvars  ## Create plan
	@terraform plan $(varFiles) -out $(ENV).tfplan -input=false -lock=false

apply:  ## Apply plan
	@terraform apply -input=false -lock=false $(ENV).tfplan

clean: tfvars ## Clean plan
	rm -f $(ENV).tfplan

.DEFAULT_GOAL := help
