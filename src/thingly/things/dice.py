import random

def roll(n=1, d=6):
    return [random.randint(1, d) for _ in range(0, n)]
