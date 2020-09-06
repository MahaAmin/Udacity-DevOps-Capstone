pipeline {
    agent any 
    stages {
        stage('Install Requirements'){
            steps{
                sh "pip3 install -r requirements.txt"
            }
        }

        stage('Lint Code'){
            steps {
                sh "bash ./run_pylint.sh"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-app .'
            }
        }

        stage('Upload image to docker-hub'){
            steps{
                echo 'uploading image to docker-hub.'
            }
        }

        stage('Blue-Green-Deployment'){
            steps{
                echo "deploying blue-green."
            }
        }
    }
}