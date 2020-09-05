#!/bin/bash
python3 -m venv ~/.udacity_capstone
source ~/.udacity_capstone/bin/activate
pip install --upgrade pip &&\
  pip install -r requirements.txt

pylint app.py