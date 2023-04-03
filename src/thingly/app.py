from flask import Flask, jsonify, render_template

from .api import init_api
from .models import db
from .things import dice


def create_app():
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
    def index():
        return render_template("index.html")

    # TODO move this elsewhere
    @app.route("/api/dice")
    @app.route("/api/dice/<int:n>")
    @app.route("/api/dice/<int:n>/<int:d>")
    def roll_dice(n=1, d=6):
        # TODO protect against overly-large n, d
        return jsonify(dice.roll(n, d))

    return app
