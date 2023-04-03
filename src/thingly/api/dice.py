"""thingly API module for dice rolls."""
from flask import Blueprint

from thingly.things import dice

diceapi = Blueprint("dice", __name__)


@diceapi.route("/dice")
@diceapi.route("/dice/<int:n>")
@diceapi.route("/dice/<int:n>/<int:d>")
def roll_dice(n: int = 1, d: int = 6) -> dict[str, list[int]]:
    """Roll `n` dice, each having `d` sides.

    Returns a list of the resulting rolls wrapped in an envelope
    appropriate for an API response.
    """
    # TODO protect against overly-large n, d
    return {"data": dice.roll(n, d)}
