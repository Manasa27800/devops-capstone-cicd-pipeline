
# DevOps Capstone Project: CI/CD Pipeline

## Project Overview

This project demonstrates a CI/CD pipeline for a Python Flask application using Docker, GitHub Actions, and Docker Hub.

Whenever code is pushed to GitHub, GitHub Actions automatically installs dependencies, runs tests, builds a Docker image, and pushes the image to Docker Hub.

## Technologies Used

- Python and Flask
- Pytest
- Docker
- Gunicorn
- Git and GitHub
- GitHub Actions
- Docker Hub

## CI/CD Pipeline Workflow

1. Developer pushes code to GitHub.
2. GitHub Actions automatically starts the workflow.
3. Python dependencies are installed.
4. Pytest runs automated tests.
5. Docker builds the application image.
6. GitHub Actions logs in to Docker Hub using GitHub Secrets.
7. The Docker image is pushed to Docker Hub with a version tag.

## Docker Image

Docker Hub repository: https://hub.docker.com/r/manasadocker/devops-capstone

Available image tags:
- `v1` - Initial application image.
- `v2` - Updated image using Gunicorn as the production server.

## Run the Application Locally

### 1. Pull the Docker image

```bash
docker pull manasadocker/devops-capstone:v2
```

### 2. Run the container

```bash
docker run -d --name devops-capstone-app -p 5000:5000 manasadocker/devops-capstone:v2
```

### 3. Test the application

Open these URLs in your browser:

- Home: http://localhost:5000/
- Health check: http://localhost:5000/health

### 4. Stop and remove the container

```bash
docker stop devops-capstone-app
docker rm devops-capstone-app
```

## Automated Testing

The project uses Pytest to verify that the application works correctly.

The tests check:
- The home endpoint returns HTTP 200 and a success status.
- The health endpoint returns HTTP 200 and a healthy status.

To run the tests locally:

```bash
pip install -r requirements.txt
pytest -v
```

## Security Practices

- Docker Hub credentials are stored as GitHub Actions Secrets.
- Secrets are not hardcoded in the application code.
- A `.dockerignore` file excludes unnecessary files from the Docker build context.
- A `.gitignore` file helps prevent virtual environments and sensitive `.env` files from being committed.
