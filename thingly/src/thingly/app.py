import os

from flask import Flask, jsonify, render_template
from .api import init_api
from .db import db
from .things import dice

def create_app(test_config=None):

    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    # TODO externalize config
    app.config.from_mapping(
        SECRET_KEY='dev',
        SQLALCHEMY_DATABASE_URI=f'sqlite:///{os.path.join(app.instance_path, "thingly.sqlite")}',
    )

    if test_config:
        app.config.from_mapping(test_config)
    else:
        app.config.from_pyfile('config.py', silent=True)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    db.init_app(app)

    with app.app_context():
        init_api(app, db)
        db.create_all()  # TODO manage this with alembic

    # TODO move this elsewhere
    @app.route('/')
    def index():
        return render_template('index.html')

    # TODO move this elsewhere
    @app.route('/api/dice')
    @app.route('/api/dice/<int:n>')
    @app.route('/api/dice/<int:n>/<int:d>')
    def roll_dice(n=1, d=6):
        # TODO protect against overly-large n, d
        return jsonify(dice.roll(n, d))


    return app
