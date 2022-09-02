# TODO fix pytest import pathing
from thingly.things import dice


def test_dice():
    r = dice.roll(n=10,d=12)
    assert len(r) == 10
    for roll in r:
        assert 1 <= roll <= 12
