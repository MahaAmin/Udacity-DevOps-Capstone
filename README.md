# Udacity Capstone Project 


## Project Steps

1. [Development](#development)
2. [Jenkins](#jenkins)
3. [Setup Kubernetes Cluster](#setup-kubernetes-cluster)
4. [CI/CD Pipeline](#ci/cd-pipeline)

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

![jenkins-sg.png](screenshots/jenkins-sg.png)

- **Create jenkins EC2:**

![jenkins-ec2.png](screenshots/jenkins-ec2.png)

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

    ![1-jenkins-blueocean.png](screenshots/1-jenkins-blueocean.png)


- **Docker With Jenkins:**

    - Install docker on jenkins server.

    - Add jenkins to docker group:
        ```
        $ sudo usermod -aG docker jenkins
        ```

    - Install "Docker" jenkin's plug-in.

    - Add Docker-Hub credentials to jenkins.

    - Use docker plug-in to build, upload, and delete docker images.

![jenkins-credentials.png](screenshots/jenkins-credentials.png)

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

    ![eks-service-iam-role.png](screenshots/eks-service-iam-role.png)

    2. Create Network (VPC,Subnets,SecurityGroups,InternetGateway,RouteTables) to deploy the cluster using **CloudFormation/amazon-eks-vpc-sample.yaml**

    ![eks-vpc.png](screenshots/eks-vpc.png)

    ![vpc-for-eks-resources.png](screenshots/vpc-for-eks-resources.png)

    3. Create AWS EKS Cluster:

    ![eks-cluster-production.png](screenshots/eks-cluster-production.png)

    4. Configure kubectl for Amazon EKS:

    ```
    $ aws eks --region us-east-2 update-kubeconfig --name production
    ```

    ```
    kubectl config current-context
    ```

    ![kubectl-config-current-context.png](screenshots/kubectl-config-current-context.png)

    5. Create worker nodes to join kubernetes cluster using **CloudFormation/amazon-eks-nodegroup.yaml**:

    ![eks-groupnode-stack.png](screenshots/eks-groupnode-stack.png)

    
    ![eks-groupnode-resources.png](screenshots/eks-groupnode-resources.png)

    6. Enable the worker nodes to join cluster using **k8s/aws-auth-cm.yaml**: 

    ```
    kubectl apply -f ~/.kube/aws-auth-cm.yaml
    ```

    check nodes :

    ```
    kubectl get nodes
    ```

    ![kubectl-get-nodes.png](screenshots/kubectl-get-nodes.png)

    ![node-groups-ec2s.png](screenshots/node-groups-ec2s.png)
    

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

    ![kubectl-get-all.png](screenshots/kubectl-get-all.png)

    Access the app from browser:

    ![app-in-browser.png](screenshots/app-in-browser.png)

<hr>

### CI/CD Pipeline

Overview: 

![](screenshots/Jenkins-Pipeline.png)

Steps:

1. Install needed packages from **requirements.txt**.

2. Linting Code:




