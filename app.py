from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello, I am Maha Amin, and this is my capstone project.'