# thingly

## Getting Started
This project uses a Makefile with a bunch of helpful targets:

```
  dev          start up an auto-reloading dev server (default)
  check        run unit test suite
  coverage     report on unit test coverage
  venv         create a virtualenv
  clean        clean up intermediate files
  realclean    clean up *everything*
  help         show this help
```

### Useful curls

```shell
# dice api - roll 4d6
curl http://localhost:5000/api/dice/4/6

# retrieve a (paginated) list of all things
curl -H 'Accept: application/vnd.api+json' http://localhost:5000/api/things
```
