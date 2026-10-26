

# DevOps Capstone Project: End-to-End CI/CD Pipeline

## 1. Project Overview

This project demonstrates an end-to-end DevOps workflow for building, containerizing, deploying, and monitoring a Python Flask web application.

The project uses Docker, Docker Hub, GitHub Actions, Kubernetes, Terraform, and Amazon Web Services (AWS).

The Flask application is containerized using Docker and published to Docker Hub. GitHub Actions automates the configured CI/CD workflow. Kubernetes manifests are used to practise container orchestration, and Terraform manages AWS infrastructure.

The application was deployed on an AWS EC2 instance and accessed through its public IP address. AWS Security Groups were configured to control network access, and Amazon CloudWatch was used to monitor EC2 CPU utilization.

This project provided hands-on experience with application deployment, CI/CD automation, Infrastructure as Code, cloud networking, monitoring, and troubleshooting.

## 2. Project Objectives

- Develop and run a Python Flask application.
- Containerize the application using Docker.
- Build and publish Docker images to Docker Hub.
- Automate the configured CI/CD workflow using GitHub Actions.
- Deploy the application using Kubernetes.
- Provision AWS infrastructure using Terraform.
- Deploy the application on an AWS EC2 instance.
- Configure AWS Security Groups.
- Monitor EC2 CPU utilization using Amazon CloudWatch.
- Practise troubleshooting and resource cleanup.
- Document the project using GitHub and Markdown.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Python | Application development |
| Flask | Web application framework |
| Gunicorn | Application server |
| Docker | Containerization |
| Docker Hub | Container image registry |
| Git | Version control |
| GitHub | Source code hosting |
| GitHub Actions | CI/CD automation |
| Kubernetes | Container orchestration |
| Terraform | Infrastructure as Code |
| AWS EC2 | Virtual server |
| AWS Security Groups | Network traffic control |
| Amazon CloudWatch | Monitoring and alarms |
| VS Code | Development environment |
| PowerShell | Running commands on Windows |

## 4. Application Development

A Python Flask application was used as the main application for this project.

The application includes a dashboard and a health-check endpoint.

### Application Endpoints

| Endpoint | Purpose |
|---|---|
| `/` | Displays the application dashboard |
| `/health` | Checks the application health endpoint |

The health endpoint returns a response similar to:

```json
{
  "status": "healthy"
}
```

A successful HTTP 200 response indicates that the health endpoint is responding.

The Flask application listens on `0.0.0.0:5000` inside the container. Gunicorn is used to serve the Flask application.

## 5. Docker Containerization

Docker was used to package the Flask application and its dependencies into a container image.

### Tasks Completed

- Created a Dockerfile for the application.
- Built a Docker image.
- Ran the application inside a container.
- Mapped host ports to container ports.
- Checked container status and logs.
- Practised stopping and restarting containers.
- Troubleshot stopped containers.

### Build the Docker Image

```bash
docker build -t devops-capstone:v3 .
```

### Run the Application Locally

```bash
docker run -d --name flask-capstone -p 5000:5000 devops-capstone:v3
```

### Check Running Containers

```bash
docker ps
```

### Check All Containers

```bash
docker ps -a
```

### View Container Logs

```bash
docker logs flask-capstone
```

### Stop and Start a Container

```bash
docker stop flask-capstone
docker start flask-capstone
```

### Test the Application

- http://localhost:5000
- http://localhost:5000/health

## 6. Docker Hub

Docker Hub was used to store the application image so it could be pulled and deployed on another machine.

### Published Image

`manasameragu/devops-capstone:v3`

### Pull the Image

```bash
docker pull manasameragu/devops-capstone:v3
```

### Run the Published Image

```bash
docker run -d --name flask-capstone -p 5000:5000 manasameragu/devops-capstone:v3
```

Using a versioned image tag such as `v3` helps identify the version being deployed.

## 7. CI/CD Pipeline Using GitHub Actions

GitHub Actions was used to automate the configured build and image publishing workflow.

The workflow configuration is stored in the `.github/workflows/` directory.

### CI/CD Workflow

1. The developer changes the application code.
2. Changes are committed using Git.
3. Code is pushed to GitHub.
4. GitHub Actions starts the configured workflow.
5. Dependencies are installed if configured in the workflow.
6. Automated tests run if configured.
7. Docker builds the application image.
8. The image is pushed to Docker Hub if the workflow includes this step and the required credentials are configured.
9. The published image can be used for deployment.

### Git Commands

Check repository status:

```bash
git status
```

Stage changes:

```bash
git add .
```

Commit changes:

```bash
git commit -m "Update DevOps capstone project"
```

Push changes:

```bash
git push origin main
```

### Pipeline Verification

The GitHub Actions workflow was checked, and a successful run showed a green status.

The pipeline demonstrates how configured build and publishing steps can be automated instead of being performed manually.

## 8. Kubernetes Deployment

Kubernetes was used to practise deploying and managing the containerized application.

The Kubernetes configuration files are stored in the `k8s/` directory.

### Kubernetes Concepts Practised

- Pods
- Deployments
- Replicas
- Services
- Container images
- Port forwarding
- Deployment verification
- Troubleshooting

The application Deployment was configured to use:

`manasameragu/devops-capstone:v3`

The Deployment was configured with three replicas.

### Check Kubernetes Resources

```bash
kubectl get pods
kubectl get deployments
kubectl get services
```

### Inspect a Deployment

```bash
kubectl describe deployment
```

### View Pod Logs

```bash
kubectl logs <pod-name>
```

Replace `<pod-name>` with the actual Pod name.

### Access the Application Using Port Forwarding

```bash
kubectl port-forward service/<service-name> 5001:5000
```

Replace `<service-name>` with the actual Service name.

Open the following URLs while port forwarding is active:

- http://localhost:5001
- http://localhost:5001/health

Port forwarding provides temporary local access to the application through the Kubernetes cluster.

## 9. AWS Infrastructure Using Terraform

Terraform was used to define and manage AWS infrastructure through configuration files.

This approach is called Infrastructure as Code (IaC).

### Terraform Files

| File | Purpose |
|---|---|
| `main.tf` | Defines the AWS provider, EC2 instance, security group, and output |
| `variables.tf` | Defines input variables |
| `terraform.tfvars` | Supplies local variable values |
| `.terraform.lock.hcl` | Records selected provider dependency versions |

### AWS Configuration

- AWS Region: `ap-south-1` (Mumbai)
- Instance type: `t3.micro`
- Operating system: Ubuntu 24.04
- EC2 key pair: `devops-aws-key`

The AMI ID must be valid for the selected AWS region.

### Initialize Terraform

```bash
terraform init
```

### Format Terraform Files

```bash
terraform fmt
```

### Validate the Configuration

```bash
terraform validate
```

### Preview Infrastructure Changes

```bash
terraform plan
```

### Apply Infrastructure Changes

```bash
terraform apply
```

Review the proposed changes before confirming the operation.

### Get the EC2 Public IP

```bash
terraform output -raw ec2_public_ip
```

### List Terraform-Managed Resources

```bash
terraform state list
```

Terraform was used to manage the EC2 instance and its associated security group.

## 10. AWS EC2 Deployment

An AWS EC2 instance was used as a remote server to run Docker containers.

Docker was installed on the Ubuntu instance, and the application image was pulled from Docker Hub.

### Connect to EC2 from PowerShell

```powershell
ssh -i "$env:USERPROFILE\.ssh\devops-aws-key" ubuntu@<EC2_PUBLIC_IP>
```

Replace `<EC2_PUBLIC_IP>` with the current public IP address of the running instance.

### Verify Docker

```bash
docker --version
sudo systemctl status docker
```

### Pull the Application Image

```bash
sudo docker pull manasameragu/devops-capstone:v3
```

### Run the Flask Application

```bash
sudo docker run -d --name flask-capstone -p 5000:5000 manasameragu/devops-capstone:v3
```

### Check Running Containers

```bash
sudo docker ps
```

### Check All Containers

```bash
sudo docker ps -a
```

### View Container Logs

```bash
sudo docker logs flask-capstone
```

### Verify the Application

Open the application using the current EC2 public IP address:

`http://<EC2_PUBLIC_IP>:5000`

Health-check endpoint:

`http://<EC2_PUBLIC_IP>:5000/health`

The application was successfully accessed through the EC2 public IP when the instance, container, and network access were configured correctly.

## 11. AWS Security Groups and Networking

An AWS Security Group controls inbound and outbound traffic for associated AWS resources.

The EC2 Security Group was configured to allow access to SSH and the application ports used in the project.

### Ports Used

| Port | Protocol | Purpose |
|---|---|---|
| 22 | TCP | SSH access to EC2 |
| 5000 | TCP | Flask application |
| 8080 | TCP | Nginx container published on the EC2 host |

### Flask Port Mapping

```bash
-p 5000:5000
```

The first port is the host port, and the second port is the container port.

### Nginx Port Mapping

```bash
-p 8080:80
```

The EC2 host listens on port 8080 and forwards traffic to port 80 inside the Nginx container.

### Security Practices

- Allow SSH access only from trusted IP addresses.
- Restrict application ports to the IP addresses that need access.
- Avoid exposing unnecessary ports to the entire internet.
- Never commit private SSH keys to GitHub.
- Never commit AWS access keys or other secrets to the repository.
- Review security group rules regularly.

An IP-restricted rule may need updating if the client's public IP address changes.

## 12. Nginx Container Practice

An Nginx container was also used to practise running multiple containers on one EC2 instance.

### Run Nginx

```bash
sudo docker run -d --name my-nginx -p 8080:80 nginx:alpine
```

### Check the Container

```bash
sudo docker ps
```

### Access Nginx

`http://<EC2_PUBLIC_IP>:8080`

This demonstrates how different containers can use different host ports on the same server.

## 13. AWS CloudWatch Monitoring

Amazon CloudWatch was used to practise monitoring EC2 CPU utilization.

A CloudWatch alarm named `devops-ec2-high-cpu` was created.

### Alarm Configuration

| Setting | Value |
|---|---|
| Alarm name | `devops-ec2-high-cpu` |
| Metric | CPUUtilization |
| Threshold | Greater than 70% |
| Period | 5 minutes |
| Evaluation | 1 datapoint |
| Region | `ap-south-1` |

The alarm was observed in the `OK` state when the metric did not breach the configured threshold.

An `OK` state means the alarm condition is not currently breached. It does not guarantee that the application itself is healthy.

### Purpose of Monitoring

- Observe EC2 CPU utilization.
- Detect CPU usage above the configured threshold.
- Practise creating and reviewing CloudWatch alarms.
- Understand the difference between infrastructure metrics and application health checks.

Notification delivery requires appropriate notification configuration.

## 14. Troubleshooting

Troubleshooting was an important part of this project.

### Docker Container Is Not Running

Check all containers:

```bash
sudo docker ps -a
```

View application logs:

```bash
sudo docker logs flask-capstone
```

Start an existing stopped container:

```bash
sudo docker start flask-capstone
```

### Application Is Not Accessible

Check the following:

1. Confirm that the EC2 instance is running.
2. Confirm that the Flask container is running.
3. Confirm that host port 5000 is published.
4. Check the EC2 Security Group inbound rule.
5. Verify that the public IP address is current.
6. Review the application container logs.
7. Test the health endpoint.

### Test the Health Endpoint on EC2

```bash
curl http://localhost:5000/health
```

### Test from Windows PowerShell

```powershell
Invoke-RestMethod http://<EC2_PUBLIC_IP>:5000/health
```

### Terraform Troubleshooting

```bash
terraform fmt
terraform validate
terraform plan
```

Review the plan before applying infrastructure changes.

### Kubernetes Troubleshooting

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

These commands help identify Pod status, configuration issues, and application errors.

## 15. Repository Structure

The project contains application code, Docker configuration, GitHub Actions workflows, Kubernetes manifests, and Terraform configuration.

The following is a simplified example. Update the filenames if the actual repository structure differs.

```text
devops-capstone/
├── .github/
│   └── workflows/
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── .terraform.lock.hcl
├── app.py
├── Dockerfile
├── requirements.txt
├── .gitignore
└── README.md
```

The `.gitignore` file excludes local development files, Terraform state files, local variable files, and sensitive key files.

Terraform state may contain sensitive information and should be stored securely.

## 16. Resource Cleanup and Cost Awareness

AWS resources can incur charges while they are in use.

Before finishing a practice session, verify the status of the EC2 instance, Docker containers, and monitoring resources.

### Stop Local Docker Containers

Run these commands in the environment where the containers exist:

```bash
docker stop flask-capstone
docker stop my-nginx
```

### Verify Container Status

```bash
docker ps
docker ps -a
```

### Stop the EC2 Instance

The EC2 instance can be stopped from the AWS Management Console when it is no longer needed.

Stopping an instance does not delete it. Attached storage and some other resources may continue to incur charges. Public IPv4 addresses may also have associated costs.

### Terraform Destroy

Use the following commands only when you intentionally want to delete Terraform-managed infrastructure:

```bash
terraform plan -destroy
terraform destroy
```

Review the plan carefully before confirming destruction.

Do not run `terraform destroy` if you still need the EC2 instance, Security Group, or other Terraform-managed resources.

Review CloudWatch alarms and other AWS resources separately before deleting them. Avoid deleting shared resources that may be used by other workloads.

## 17. Key Learnings

Through this project, I gained hands-on practice with:

- Developing and running a Flask application.
- Containerizing an application using Docker.
- Building, tagging, and publishing Docker images.
- Using Docker Hub as an image registry.
- Automating configured build and publishing steps with GitHub Actions.
- Using Git and GitHub for version control.
- Deploying applications using Kubernetes manifests.
- Understanding Pods, Deployments, replicas, and Services.
- Provisioning AWS infrastructure using Terraform.
- Connecting to EC2 using SSH.
- Running Docker containers on a remote server.
- Understanding host ports and container ports.
- Configuring AWS Security Groups.
- Monitoring CPU utilization using CloudWatch.
- Troubleshooting stopped containers and connectivity problems.
- Understanding cloud resource cleanup and cost awareness.

## 18. Future Improvements

Potential improvements include:

- Add more automated unit and integration tests.
- Add health checks to the container and Kubernetes Deployment.
- Configure Docker container restart policies.
- Improve secrets management using GitHub Actions secrets and AWS IAM best practices.
- Deploy to a managed Kubernetes service such as Amazon EKS.
- Configure secure remote Terraform state storage and state locking.
- Add CloudWatch notifications and application log monitoring.
- Use HTTPS and a domain name for production-style access.
- Implement a deployment rollback strategy.
- Add automated infrastructure validation to the CI/CD pipeline.

## 19. Conclusion

This capstone project provided practical experience with an end-to-end DevOps workflow, starting with a Python Flask application and extending through Docker containerization, CI/CD automation, Kubernetes deployment, Terraform-based AWS infrastructure management, EC2 deployment, networking, and CloudWatch monitoring.

The project helped develop practical familiarity with commonly used DevOps tools and the steps involved in building, publishing, deploying, verifying, and troubleshooting a containerized application.

## 20. Application Screenshot

The screenshot of the working application dashboard will be added below.

Save the image inside the repository, for example at `docs/images/application-dashboard.png`, and then add the following Markdown image reference.

<img width="3814" height="1716" alt="devops_capstone" src="https://github.com/user-attachments/assets/74cce17d-58bb-4447-9a6a-e20c17c1a556" />


## Author

Manasa Meragu

Project: DevOps Capstone Project - End-to-End CI/CD Pipeline
