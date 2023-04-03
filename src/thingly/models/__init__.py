"""thingly models package."""
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, DateTime, Integer, func

db = SQLAlchemy()


# TODO remove ignore when/if 'error: Name "db.Model" is not defined' gets fixt
class BaseModel(db.Model):  # type: ignore
    """Base thingly model; provices an id and created/modified timestamps."""

    __abstract__ = True
    id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=func.now())
    last_modified = Column(DateTime, default=func.now(), onupdate=func.now())
