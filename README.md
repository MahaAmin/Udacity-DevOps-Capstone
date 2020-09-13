# Udacity Capstone Project 


## Project Overview

Capstone project for Udacity's "Cloud DevOps Engineer" Nanodegree Program.

<hr>

## Objectives

- Working in AWS
- Using Jenkins to implement Continuous Integration and Continuous Deployment
- Building pipelines
- Working with Ansible and CloudFormation to deploy clusters
- Building Kubernetes clusters
- Building Docker containers in pipelines

<hr>

## Tools Used

- Git & GitHub
- AWS & AWS-CLI
- Python3 
- Flask framework.
- pip3
- Pylint
- Docker & Docker-Hub Registery
- Jenkins
- Kubernetes CLI (kubectl)
- EKS
- CloudFormation
- BASH
- LucidChart

<hr>

## Project Steps

1. [Development](#development)
2. [Jenkins](#jenkins)
3. [Setup Kubernetes Cluster](#setup-kubernetes-cluster)
4. [CI/CD Pipeline](#ci/cd-pipeline)
5. [Cost of Greatness](#cost-of-greatness)

<hr>

### Development

 - Simple flask application.

<hr>

- **Docker Containerization (Local manual check):**

    Run docker flask-app container:

    ```
        $./run_docker.sh
    ```

<br>

- **Push docker image to docker-hub (Local manual check):**

    ```
        $./upload_docker.sh
    ```
<hr>

### Jenkins

- **Create security-group for jenkins:**

![1-jenkins-sg.png](screenshots/1-jenkins-sg.png)

- **Create jenkins EC2:**

![2-jenkins-ec2.png](screenshots/2-jenkins-ec2.png)

- **Connect to jenkins ec2:**

    ```
    ssh -i udacity-capstone.pem ubuntu@ec2-18-220-188-146.us-east-2.compute.amazonaws.com
    ```

- **Setup Jenkins Server:** 

    - Install java:

        ```
        $ sudo apt update && sudo apt install default-jdk;
        ```

    - Install Jenkins.

    - Install pip3 and venv:
        ```
        $ sudo apt install python3-pip
        ```
        ```
        $ sudo apt-get install python3-venv
        ```

    - Install "Blue-Ocean-Aggregator" Plug-In.

    ![3-jenkins-blueocean.png](screenshots/3-jenkins-blueocean.png)


- **Docker With Jenkins:**

    - Install docker on jenkins server.

    - Add jenkins to docker group:
        ```
        $ sudo usermod -aG docker jenkins
        ```

    - Install "Docker" jenkin's plug-in.

    - Add Docker-Hub credentials to jenkins.

    - Use docker plug-in to build, upload, and delete docker images.

![4-jenkins-credentials.png](screenshots/4-jenkins-credentials.png)

- **AWS With Jenkins:**

    - Install "Pipeline-AWS" Plug-In.
    - Add AWS-User credentials to jenkins.
    

- **Kubernetes With Jenkins:**

    - Install kubectl.

<hr>

### Setup Kubernetes Cluster

Create kubernetes "Production" Cluster on AWS using EKS: (From my local machine)

- Useful resource [here](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) .

- Install AWS CLI.
- Install eksctl.
- Install kubectl.
- Create Amazon EKS cluster:
    1. Create an AWS IAM service role:

    ![5-eks-service-iam-role.png](screenshots/5-eks-service-iam-role.png)

    2. Create Network (VPC,Subnets,SecurityGroups,InternetGateway,RouteTables) to deploy the cluster using **CloudFormation/amazon-eks-vpc-sample.yaml**

    ![6-eks-vpc.png](screenshots/6-eks-vpc.png)

    ![6.1-vpc-for-eks-stack.png](screenshots/6.1-vpc-for-eks-stack.png)

    ![7-vpc-for-eks-resources.png](screenshots/7-vpc-for-eks-resources.png)

    3. Create AWS EKS Cluster:

    ![7.1-eks-cluster-production.png](screenshots/7.1-eks-cluster-production.png)

    4. Configure kubectl for Amazon EKS:

    ```
    $ aws eks --region us-east-2 update-kubeconfig --name production
    ```

    ```
    kubectl config current-context
    ```

    ![8-kubectl-config-current-context.png](screenshots/8-kubectl-config-current-context.png)

    5. Create worker nodes to join kubernetes cluster using **CloudFormation/amazon-eks-nodegroup.yaml**:

    ![9-eks-groupnode-stack.png](screenshots/9-eks-groupnode-stack.png)

    
    ![10-eks-groupnode-resources.png](screenshots/10-eks-groupnode-resources.png)

    6. Enable the worker nodes to join cluster using **k8s/aws-auth-cm.yaml**: 

    ```
    kubectl apply -f ~/.kube/aws-auth-cm.yaml
    ```

    check nodes :

    ```
    kubectl get nodes
    ```

    ![11-kubectl-get-nodes.png](screenshots/11-kubectl-get-nodes.png)

    ![12-node-groups-ec2s.png](screenshots/12-node-groups-ec2s.png)
    

    7. Test deploying flask-app on the production cluster outside pipeline:

    ```
    kubectl apply -f k8s/blue-deployment.yaml 
    ```

    ```
    kubectl apply -f k8s/service.yaml 
    ```

    ```
    kubectl get all
    ```

    ![13-kubectl-get-all.png](screenshots/13-kubectl-get-all.png)

    Access the app from browser:

    ![14-app-in-browser.png](screenshots/14-app-in-browser.png)

<hr>

### CI/CD Pipeline

Overview: 

![15-Jenkins-Pipeline.png](screenshots/15-Jenkins-Pipeline.png)

Steps:

1. Install needed packages from **requirements.txt**.

2. Linting Code:

![16-lint-failed.png](screenshots/16-lint-failed.png)


![17-lint-success.png](screenshots/17-lint-success.png)

3. Set K8S Context: To enable jenkins to run kubectl commands with "aws-user" credentials stored in jenkins server.

4. Build Green Docker Image.

5. Push green image (mahaamin97/pre-production-flask-app) to docker-hub registery:

    - Link to [pre-production-flask-app Image](https://hub.docker.com/repository/docker/mahaamin97/pre-production-flask-app/general)

![18-docker-hub.png](screenshots/18-docker-hub.png)

6. Clean Up green image: delete pre-production-flask-app Image from jenkins server after uploading it to docker-hub, to save jenkin's server disk space.

7. Blue/Green Deployment Demonstration:

    - Blue --> production deployment (flask-app)
    - Green --> pre-production deployment (pre-production-flask-app)
    - flask-app-svc --> main service endpoint.
    - test-svc --> service on green deployment only for testing purposes.

    - If green deployment succeeded : 
        - switch traffic to green deployment
        - changes are deployed to blue deployment (pipeline ends having two identical environments) 
        
        - switch back service to blue deployment


    - Green deployment succeeded:

    ![19-blue-deployment.png](screenshots/19-blue-deployment.png)

    Green and Blue environments are the same (until new commit happens)

    ![20-blue-green-both-blue.png](screenshots/20-blue-green-both-blue.png)


    - Else if Green deployment failed, the main service (flask-app-svc) still points to blue deployment, while green deployment changed and can be accessed via test-svc:

    ![21-green-deployment-failed.png](screenshots/21-green-deployment-failed.png)

    ![22-blue-green-failed.png](screenshots/22-blue-green-failed.png)


8. Test Green Deployment:

![23-test-green-deployment.png](screenshots/23-test-green-deployment.png)


9. Blue Docker Image:

    - Link to [flask-app Image](https://hub.docker.com/repository/docker/mahaamin97/flask-app) on docker-hub.

<hr>

### Cost of Greatness

- **Final Jenkins Dashboard:**

![24-jenkins-dashboard.png](screenshots/24-jenkins-dashboard.png)


- **AWS Billing:**

![25-aws-billing.png](screenshots/25-aws-billing.png)

<hr>