import flask_restless

from .models.thing import Thing

def init_api(app, db):
    # Create the Flask-Restless API manager.
    manager = flask_restless.APIManager(app, session=db.session)

    # Create API endpoints, which will be available at /api/<tablename>
    manager.create_api(Thing, methods=['GET', 'POST', 'PUT', 'DELETE'])
