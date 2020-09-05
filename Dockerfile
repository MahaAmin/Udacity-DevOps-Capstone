FROM python:3.8-buster 

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt 

ARG FLASK_APP=app.py

ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]