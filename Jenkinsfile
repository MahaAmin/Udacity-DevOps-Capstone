pipeline {
    environment{
        preProductionRegistry = "mahaamin97/pre-production-flask-app"
        registryCredential = 'docker-hub' 
        greenDockerImage = '' 
        blueDockerImage = ''
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

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build preProductionRegistry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Upload Green Image to Docker-Hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        greenDockerImage.push()
                    }
                }
            }
        }

        stage('Clean Up Green Image'){
            steps { 
                sh "docker rmi $preProductionRegistry:$BUILD_NUMBER" 
            }
        }

        stage('Green Deployment'){
            steps {
                sh "whoami && aws configure list && kubectl get all"
            }
        }

        stage('Unit Tests on Green Deployment'){
            steps{
                echo "deploying blue-green."
            }
        }

        stage('Blue Deployment'){
            steps{
                echo "Blue deployment"
            }
        }

        stage('Destroy Green Deployment'){
            steps{
                echo "Destroying green deployment"
            }
        }
    }
}