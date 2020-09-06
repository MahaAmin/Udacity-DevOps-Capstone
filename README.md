# Udacity Capstone Project 


## Project Steps

- **Development:**

    Simple flask application.

<br>

- **Docker Containerization:**

    Run docker flask-app container:

    ```
        $./run_docker.sh
    ```

<br>

- **Push docker image to docker-hub:**

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
    - Install Docker.

    ![1-jenkins-blueocean](screenshots/1-jenkins-blueocean.png)


