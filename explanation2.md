# Vagrant & Ansible Automation

## Introduction

This project demonstrates how to provision and configure an e-commerce web application using **Vagrant**, **Ansible**, and **Docker**. The application consists of a **frontend**, **backend**, and **MongoDB** service, each containerized and orchestrated through Ansible roles.

All tasks are automated using a structured Ansible playbook and Vagrant setup, providing a consistent and reproducible environment for deployment.


## Docker Setup Role
Objective: This role sets up the Docker environment, ensuring the installation of Docker Engine, Docker Compose, and the project repository from GitHub. Docker is a crucial dependency, as the frontend, backend, and MongoDB services will all run inside Docker containers.

Execution Order: This role executes first, as Docker must be set up before any other services. All subsequent roles depend on Docker being correctly installed and configured.

## Tasks:

Install Python3, Pip, and Docker SDK: Installs the necessary dependencies to manage Docker through Python.

Install Docker and Docker Compose: Adds the Docker repository, installs Docker Engine and Docker Compose, and configures the system.

Clone the GitHub Repository: Retrieves the application code from GitHub to set up the project.

Check and Copy docker-compose.yml: Ensures the Docker Compose file is available for use.

Run docker-compose up: Starts the application services defined in the Docker Compose file.

Ansible Modules Used:

apt, apt_key, and apt_repository for package installation.

pip for installing Python packages.

user to add the current user to the Docker group.

get_url to download the Docker Compose binary.

command to verify the installation of Docker Compose.

## Frontend Setup Role
Objective: Deploys the frontend application, which provides the user interface for the e-commerce platform.

Execution Order: This role runs after Docker is set up, as the frontend needs to be deployed inside a Docker container. If the frontend image isn't already available, it will be built from source.

## Tasks:

Pull Frontend Image: Fetches the latest frontend image from the Docker repository.

Build Frontend Image: If necessary, the frontend image is built locally from the source code.

Ansible Modules Used:

docker_image to pull the frontend Docker image.

command to build the frontend Docker image using docker build.

## MongoDB Setup Role
Objective: Configures and runs MongoDB as the data store for the application, ensuring persistent storage even when containers are restarted.

Execution Order: MongoDB is set up before the backend, as the backend service depends on MongoDB for data storage and retrieval.

Tasks:

Create Network and Volume: Establishes a Docker network and a persistent volume for MongoDB's data.

Run MongoDB Container: Starts the MongoDB container, using the created volume for data persistence and connecting it to the necessary network.

Ansible Modules Used:

docker_network to create a network for communication between containers.

docker_volume to set up a volume for MongoDB's data persistence.

docker_container to deploy the MongoDB container.

## Backend Setup Role
Objective: Deploys the backend service, which handles API requests and interacts with the MongoDB instance.

Execution Order: The backend is deployed after MongoDB to ensure that it can connect to the database service.

## Tasks:

Pull Backend Image: Retrieves the backend image from the repository.

Run Backend Container: Starts the backend container, linking it to the MongoDB container via the Docker network.

Build Backend Image: Builds the backend image locally if there are changes to the source code.

Ansible Modules Used:

docker_image to fetch the backend Docker image.

docker_container to run the backend container, connecting it to MongoDB.

command for building the backend image using docker build.

## Repository Contents:
vars/main.yml: This file contains variables shared across different roles, including the compose_file, github_repo, and github_branch settings for cloning the repository.

README.md: The README file provides a detailed guide on how to clone the project, build the Docker images, and run the application using vagrant up and Ansible for configuration.