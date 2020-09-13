"""
main module flask app
"""
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    """
    main route
    """
    return render_template('green.html')
