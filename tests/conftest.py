from thingly.app import create_app

import pytest


@pytest.fixture(scope='function')  # TODO revisit scope if this gets slow
def app():
    app = create_app(test_config={
        'SECRET_KEY': 'test',
        'SQLALCHEMY_DATABASE_URI': 'sqlite:///:memory:'
    })

    yield app

    # TODO any shutdown/cleanup tasks here


@pytest.fixture(scope='function')
def db(app):
    with app.app_context():
        yield app.db  # we hung db off of app in app.py

    # TODO database cleanup?


@pytest.fixture
def client(app):
    return app.test_client()


@pytest.fixture
def runner(app):
    return app.test_cli_runner()
