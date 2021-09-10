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
		echo "$(BOLD)$(RED)ENV is missing$(RESET)"; \
		exit 1; \
	fi

	@if [ -z $(TEAM) ]; then \
		echo "$(BOLD)$(RED)TEAM is missing$(RESET)"; \
		exit 1; \
	fi	

	@if [ ! -d "creds" ]; then \
		mkdir -p creds; \
	fi

tfvars: set-env  ## Find and store all tfvars file
	$(eval varFiles=$(shell sh -c "find environments/$(TEAM)/$(ENV) -maxdepth 1 -name '*.tfvars'" | awk '{print "-var-file="$$0}' | perl -pe 'eof||s|$/| |'))

backend: set-env  ## Find backend file
	$(eval backend=$(shell sh -c "find environments/$(TEAM)/$(ENV) -maxdepth 1 -name '*.hcl'"))

generate_config:
	$(eval LIST=$(shell sh -c "find environments/* -type d -mindepth 1 -maxdepth 2"))

	for i in $(LIST); do \
		python3 rb.py --env_path=$$i; \
	done

init: set-env backend  ## Initialize a working directory
	@terraform init -backend-config=$(backend)

plan: set-env tfvars  ## Create plan
	@terraform plan $(varFiles) -out $(TEAM)_$(ENV).tfplan -input=false -lock=false

apply:  ## Apply plan
	@terraform apply -input=false -lock=false $(TEAM)_$(ENV).tfplan

destroy: set-env tfvars  ## Destroy state
	@terraform destroy -auto-approve $(varFiles)

clean: tfvars ## Clean plan
	rm -f $(TEAM)_$(ENV).tfplan

.DEFAULT_GOAL := help
