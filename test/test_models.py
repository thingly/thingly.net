"""Test models."""
from thingly.models.user import User


def test_user(db):
    """Test user creation."""
    user = User(name="Joe Smith")
    db.session.add(user)
    db.session.commit()

    # basic checks to see whether fields got populated
    assert user.id is not None
    assert user.created_at is not None
    assert user.last_modified is not None
