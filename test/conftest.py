"""Test configuration and fixtures."""
import pytest

from thingly.app import create_app
from thingly.app import db as thingly_db


@pytest.fixture
def app():
    """Flask app fixture."""
    app = create_app()

    yield app

    # TODO any shutdown/cleanup tasks here


@pytest.fixture(scope="function")
def db(app):
    """Database fixture."""
    with app.app_context():
        yield thingly_db

    # TODO database cleanup?


@pytest.fixture
def client(app):
    """Application client fixture."""
    return app.test_client()


@pytest.fixture
def runner(app):
    """Command-line runner fixture."""
    return app.test_cli_runner()
