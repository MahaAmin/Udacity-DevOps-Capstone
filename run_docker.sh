# Build flask-app image
sudo docker build -t flask-app .

# Run flask-app container
sudo docker run -p 5000:5000 --name flask-app flask-app