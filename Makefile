# Makefile design taken from https://rosszurowski.com/log/2022/makefiles
FLASK=venv/bin/flask
TOOLS=$(patsubst %, venv/bin/%, coverage flake8 pytest)

dev: $(FLASK) ## start up an auto-reloading dev server (default)
	FLASK_APP=src/thingly/app.py $(FLASK) --debug run

check: venv/bin/coverage venv/bin/pytest ## run unit test suite
	@venv/bin/coverage run -m pytest
.PHONY: check

coverage: check ## report on unit test coverage
	@venv/bin/coverage report
.PHONY: coverage

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

$(TOOLS): venv requirements-dev.txt
	venv/bin/pip install -r requirements.txt -r requirements-dev.txt
