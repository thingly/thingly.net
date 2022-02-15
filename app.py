from flask import Flask, jsonify, render_template
from thingly import dice

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/api/dice')
@app.route('/api/dice/<int:n>')
@app.route('/api/dice/<int:n>/<int:d>')
def roll_dice(n=1, d=6):
    # TODO protect against overly-large n, d
    return jsonify(dice.roll(n, d))
