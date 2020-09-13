"""
main module flask app
"""
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    """
    main route
    """
    return 'Hello, I am Maha Amin, and this is my capstone project.'
