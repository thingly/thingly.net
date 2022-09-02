# thingly

## Getting Started
You'll need a virtual environment with dependencies installed:

```shell
source activate
```

You can then start up a development server using:

```shell
flask --debug run
```

## Testing
Unit tests can be run using `pytest`. To take a look at test coverage do:

```shell
coverage run -m pytest
coverage report
```

### Useful curls

```shell
# dice api - roll 4d6
curl http://localhost:5000/api/dice/4/6

# retrieve a (paginated) list of all things
curl -H 'Accept: application/vnd.api+json' http://localhost:5000/api/things
```
