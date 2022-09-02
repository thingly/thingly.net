from . import db
from sqlalchemy import func, Column, DateTime, Integer


class Thing(db.Model):
    __tablename__ = 'things'

    id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=func.now())
    last_modified = Column(DateTime, default=func.now(), last_modified=func.now())
