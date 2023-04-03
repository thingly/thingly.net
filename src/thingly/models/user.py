"""thingly user model."""
from sqlalchemy import Column, String

from . import BaseModel


class User(BaseModel):
    """Basic user model."""

    __tablename__ = "users"
    name = Column(String, unique=True, nullable=False)
