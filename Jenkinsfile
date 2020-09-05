pipeline {
    agent any 
    stages {
        stage('Build Docker Image') {
            steps {
                echo 'building docker image' 
            }
        }

        stage('Lint Code'){
            steps {
                echo 'linting code.'
            }
        }

        stage('Upload image to docker-hub'){
            steps{
                echo 'uploading image to docker-hub.'
            }
        }
    }
}