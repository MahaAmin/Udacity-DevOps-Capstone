pipeline {
    agent any 
    stages {
        stage('Install Requirements'){
            steps{
                sh "bash ./run_pylint.sh"
            }
        }

        stage('Lint Code'){
            steps {
                sh "pylint app.py"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'building docker image' 
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