from flask import Blueprint

from thingly.things import dice
diceapi = Blueprint("dice", __name__)


@diceapi.route("/dice")
@diceapi.route("/dice/<int:n>")
@diceapi.route("/dice/<int:n>/<int:d>")
def roll_dice(n=1, d=6):
    # TODO protect against overly-large n, d
    return { "data": dice.roll(n, d) }
