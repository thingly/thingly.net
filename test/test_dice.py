"""Test dice."""
from thingly.things import dice


def test_dice():
    """Test 10d12 dice roll."""
    rolls = dice.roll(n=10, d=12)
    assert len(rolls) == 10
    for roll in rolls:
        assert 1 <= roll <= 12
