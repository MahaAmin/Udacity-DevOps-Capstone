pipeline {
    environment{
        registry = "mahaamin97/flask-app"
        registryCredential = 'docker-hub' 
        dockerImage = '' 
    }
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
                script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Upload image to docker-hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean Up Images'){
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }

        stage('Blue-Green-Deployment'){
            steps{
                echo "deploying blue-green."
            }
        }
    }
}