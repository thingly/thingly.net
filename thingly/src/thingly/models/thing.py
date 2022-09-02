from ..db import db
from sqlalchemy import Column, Integer


class Thing(db.Model):
    __tablename__ = 'things'

    id = Column(Integer, primary_key=True)
