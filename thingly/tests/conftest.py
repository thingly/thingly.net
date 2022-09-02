from thingly import create_app

import pytest


@pytest.fixture
def app():
    app = create_app(test_config={
        'SECRET_KEY': 'test',
        'SQLALCHEMY_DATABASE_URI': 'sqlite:///:memory:'
    })

    yield app

    # TODO any shutdown/cleanup tasks here

@pytest.fixture
def client(app):
    return app.test_client()


@pytest.fixture
def runner(app):
    return app.test_cli_runner()
