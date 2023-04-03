# Makefile design taken from https://rosszurowski.com/log/2022/makefiles
FLASK=venv/bin/flask
TOOLS=$(patsubst %, venv/bin/%, black coverage djlint flake8 isort mypy pyclean pytest)

default: help

dev: $(FLASK) .flaskenv ## start up an auto-reloading dev server
	$(FLASK) --debug run

check: venv/bin/coverage venv/bin/pytest ## run unit test suite
	@venv/bin/coverage run -m pytest
.PHONY: check

coverage: check venv/bin/coverage ## report on unit test coverage
	@venv/bin/coverage report
.PHONY: coverage

format: venv/bin/black venv/bin/isort venv/bin/djlint ## auto-format all source code
	@echo "formatting source code..."
	@venv/bin/black src test
	@echo "organizing imports..."
	@venv/bin/isort src test
	@echo "formatting jinja templates..."
	@venv/bin/djlint --reformat src/thingly/templates
.PHONY: format

# note: if djlint is erroring spuriously make it warn instead using:
# @venv/bin/djlint --warn src/thingly/templates
lint: venv/bin/flake8 venv/bin/djlint venv/bin/mypy ## run code style checks
	@echo "linting source code..."
	@venv/bin/flake8
	@echo "linting jinja templates..."
	@venv/bin/djlint src/thingly/templates
	#echo "static type checking..."
	@venv/bin/mypy src
.PHONY: lint

venv: ## create a virtualenv
	python3 -mvenv venv

clean: venv/bin/pyclean ## clean up cached files
	@venv/bin/pyclean src test
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
