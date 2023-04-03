"""thingly dice."""
import random


def roll(n: int = 1, d: int = 6) -> list[int]:
    """Roll `n` dice, each having `d` sides.

    Returns a list of the resulting rolls.
    """
    return [random.randint(1, d) for _ in range(0, n)]
