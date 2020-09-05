# Tag image
docker tag flask-app:latest mahaamin97/flask-app:latest

# Login to docker-hub
docker login --username=mahaamin97

# Push image
docker push mahaamin97/flask-app:latest