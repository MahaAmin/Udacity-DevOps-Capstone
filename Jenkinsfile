pipeline {
    environment{
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

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'aws-credentials'){
                    sh "kubectl config set-context arn:aws:eks:us-east-2:319947095944:cluster/production"
                }
            }
        }

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build "mahaamin97/pre-production-flask-app"
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
                sh "docker rmi $greenDockerImage" 
            }
        }

        stage('Green Deployment'){
            steps {
                withAWS(credentials:'aws-credentials'){
                    sh "export DEPLOY_ENV=pre-production-flask-app && kubectl apply -f k8s/green-deployment.yaml && kubectl apply -f k8s/service.yaml"
                }
            }
        }

        stage('Test Green Deployment'){
            steps{
                echo "Making some tests."
            }
        }

        stage('Build Blue Docker Image') {
            steps {
                script{
                    blueDockerImage = docker.build "mahaamin97/flask-app"
                }
            }
        }

        stage('Upload Blue Image to Docker-Hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        blueDockerImage.push()
                    }
                }
            }
        }

        stage('Clean Up Blue Image'){
            steps { 
                sh "docker rmi $blueDockerImage" 
            }
        }

        stage('Blue Deployment'){
            steps {
                withAWS(credentials:'aws-credentials'){
                    sh "export DEPLOY_ENV=flask-app && kubectl apply -f k8s/blue-deployment.yaml && kubectl apply -f k8s/service.yaml"
                }
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