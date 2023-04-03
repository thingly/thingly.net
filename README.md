# thingly

## Getting Started
This project uses a Makefile with a bunch of helpful targets:

```
  dev          start up an auto-reloading dev server
  check        run unit test suite
  coverage     report on unit test coverage
  lint         run code style checks
  venv         create a virtualenv
  clean        clean up intermediate files
  realclean    clean up *everything*
  help         show this help
```

### Useful curls

```shell
# dice api - roll 4d6
curl http://localhost:5000/api/dice/4/6

# create a user named Joe Smith
curl -XPOST -d'{"data": { "type": "users", "attributes": {"name": "Joe Smith"}}}' -H 'Content-Type: application/vnd.api+json' -H 'Accept: application/vnd.api+json' http://127.0.0.1:5000/api/users

# retrieve a list of all users
curl -H 'Accept: application/vnd.api+json' http://127.0.0.1:5000/api/users
```
