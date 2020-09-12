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

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'eks-admin'){
                    sh "kubectl config set-context arn:aws:eks:us-east-2:319947095944:cluster/production"
                }
            }
        }

        stage('Test kubectl'){
            steps {
                sh "kubectl get all"
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