# Makefile design taken from https://rosszurowski.com/log/2022/makefiles
FLASK=venv/bin/flask
TOOLS=$(patsubst %, venv/bin/%, black coverage flake8 isort pytest)

default: help

dev: $(FLASK) .flaskenv ## start up an auto-reloading dev server
	$(FLASK) --debug run

check: venv/bin/coverage venv/bin/pytest ## run unit test suite
	@venv/bin/coverage run -m pytest
.PHONY: check

coverage: check ## report on unit test coverage
	@venv/bin/coverage report
.PHONY: coverage

format: venv/bin/black ## auto-format all source code
	@venv/bin/black -q src tests
	@venv/bin/isort src tests
.PHONY: format

lint: venv/bin/flake8 ## run code style checks
	@$<
.PHONY: lint

venv: ## create a virtualenv
	python3 -mvenv venv

clean: ## clean up intermediate files
.PHONY: clean

realclean: clean ## clean up *everything*
	rm -rf venv
.PHONY: realclean

help: ## show this help
	@echo "\nSpecify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-12s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help

$(FLASK): venv requirements.txt
	venv/bin/pip install -r requirements.txt
	@touch $@ $^ # prevent re-installing every time

$(TOOLS): venv requirements.txt requirements-dev.txt
	venv/bin/pip install -r requirements.txt -r requirements-dev.txt
	@touch $(TOOLS) $^ # prevent re-installing every time
