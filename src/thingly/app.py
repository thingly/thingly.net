"""thingly app."""
from flask import Flask, render_template

from thingly.api import init_api
from thingly.api.dice import diceapi
from thingly.models import db


def create_app() -> Flask:
    """Flask application factory."""
    # create and configure the app
    app = Flask(__name__)

    # pull config from env vars
    app.config.from_prefixed_env()

    db.init_app(app)

    with app.app_context():
        init_api(app, db)
        db.create_all()  # TODO manage this with alembic

    # TODO move this elsewhere
    @app.route("/")
    @app.route("/index.html")
    def index() -> str:
        return render_template("index.jinja")

    app.register_blueprint(diceapi, url_prefix="/api")

    return app
