import flask_restless
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

from thingly.models.user import User


def init_api(app: Flask, db: SQLAlchemy) -> None:
    """initialize API endpoints based on our models"""
    # Create the Flask-Restless API manager.
    manager = flask_restless.APIManager(app, session=db.session)

    # Create API endpoints, which will be available at /api/<tablename>
    manager.create_api(User, methods=["GET", "POST", "PUT", "DELETE"])
