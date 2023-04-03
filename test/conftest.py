import pytest

from thingly.app import create_app
from thingly.app import db as thingly_db


@pytest.fixture
def app():
    app = create_app()

    yield app

    # TODO any shutdown/cleanup tasks here


@pytest.fixture(scope="function")
def db(app):
    with app.app_context():
        yield thingly_db

    # TODO database cleanup?


@pytest.fixture
def client(app):
    return app.test_client()


@pytest.fixture
def runner(app):
    return app.test_cli_runner()
