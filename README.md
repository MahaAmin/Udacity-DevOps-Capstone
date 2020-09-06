# Udacity Capstone Project 


## Project Steps

- **Development:**

    Simple flask application.

<br>

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


- **Setup Jenkins Server with Blue Ocean on AWS:** 

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

    ![1-jenkins-blueocean](screenshots/1-jenkins-blueocean.png)


- **Docker With Jenkins:**

    - Install docker on jenkins server.

    - Add jenkins to docker group:
        ```
            $ sudo usermod -aG docker jenkins
        ```

    - Install "Docker" jenkin's plug-in.

    - Add Docker-Hub credentials to jenkins.

    - Use docker plug-in to build, upload, and delete docker images.

