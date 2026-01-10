# Azure DevOps Live Project

## Day 1
- Simple HTML app
- Dockerized using nginx:alpine

## Day 2
- Git & GitHub basics
- Repository initialization
- Branching strategy

## Tech Stack
- Git
- GitHub
- Docker
- Jenkins

End-to-end CI/CD using Azure DevOps, Docker, Kubernetes (AKS), Prometheus, and Grafana.

Objective

To build a real-world DevOps pipeline that:

Builds an application automatically

Creates Docker images

Pushes images to a registry

Deploys the application to Kubernetes

Adds monitoring readiness (Prometheus-ready)

Tools & Technologies Used
Category	Tools
Source Control	GitHub
CI/CD	Azure DevOps
Containerization	Docker
Orchestration	Azure Kubernetes Service (AKS)
Cloud	Microsoft Azure
Monitoring (planned)	Prometheus, Grafana
Project Architecture (High Level)
Developer → GitHub
        → Azure DevOps Pipeline
        → Docker Build
        → Container Registry
        → AKS Deployment
        → Application Exposed
        → Monitoring (next phase)

Day-wise Execution Summary
✅ Day 1 – Project Setup

Created GitHub repository

Added application source code

Created Dockerfile

Verified app runs locally using Docker

✅ Day 2 – CI Pipeline (Completed Yesterday)
1️⃣ Azure DevOps Pipeline Creation

Created YAML-based pipeline

Connected GitHub repository

Triggered pipeline on code push

2️⃣ Build Stage

Pulled application code

Built Docker image

Tagged image using build number

- task: Docker@2
  inputs:
    command: build
    Dockerfile: '**/Dockerfile'
    tags: $(Build.BuildId)

3️⃣ Push Stage

Logged into container registry

Pushed Docker image successfully

Verified image exists in registry

❌ Removed Topic (As Requested)

Azure Key Vault integration

Service connection error:

ConnectedServiceName references service connection which could not be found


Decision: ❌ Removed from scope

4️⃣ Kubernetes Deployment (Started)

Kubernetes YAML files:

deployment.yaml

service.yaml

Deployment highlights

Replica-based deployment

Container pulled from registry

Port exposed

replicas: 2
containers:
- name: app
  image: <registry>/app:latest

5️⃣ Service Exposure

Kubernetes Service created

Application exposed using NodePort / LoadBalancer

Verified app access via browser

Validation Steps
Check	Status
Docker image build	✅ Success
Pipeline execution	✅ Success
Image push	✅ Success
AKS deployment	✅ In progress
Service access	✅ Verified
Monitoring	🔄 Next step
⚠️ Problems Faced During Implementation & How They Were Solved

(Azure DevOps + Kubernetes + Prometheus + Grafana)

Project Context

End-to-end CI/CD using Azure DevOps, Docker, Kubernetes (AKS), Prometheus, and Grafana.

❌ Issue 1: Azure DevOps Pipeline Failed – Missing Azure Key Vault Service Connection
Error
ConnectedServiceName references service connection azure-kv-connection
which could not be found or is disabled

Cause

Pipeline YAML referenced Azure Key Vault

Service connection was not created

Key Vault not required for this learning project

Solution

Removed AzureKeyVault@2 task from pipeline

Simplified pipeline to CI → Docker → Kubernetes

Lesson Learned

Avoid adding optional cloud services unless access and RBAC are ready.

❌ Issue 2: YAML Pipeline Validation Failed
Error
The pipeline is not valid. Job Build: Step input invalid

Cause

YAML indentation mistakes

Incorrect task input parameters

Solution

Fixed indentation

Followed official Azure DevOps task syntax

Validated pipeline before execution

Lesson Learned

YAML is fragile — start with minimal working pipelines.

❌ Issue 3: Docker Image Built Locally but Failed in Azure Pipeline
Cause

Wrong Dockerfile path

Assumption that local Docker behavior = pipeline agent behavior

Solution

Corrected Dockerfile path

Used Microsoft-hosted agent with Docker preinstalled

Dockerfile: '**/Dockerfile'

Lesson Learned

CI agents are isolated environments — never assume local parity.

❌ Issue 4: Docker Push Failed – Registry Authentication Error
Error
denied: requested access to the resource is denied

Cause

Docker registry credentials not configured

Missing service connection in Azure DevOps

Solution

Created Docker registry service connection

Linked it in pipeline YAML

Lesson Learned

Docker build works without auth, Docker push never does.

❌ Issue 5: Kubernetes Pods Stuck in ImagePullBackOff
Cause

Incorrect image name / tag in deployment.yaml

Registry access issue

Solution

Corrected image name and tag

Used public image OR configured registry access

image: username/app:latest

Lesson Learned

Kubernetes pulls exactly what is defined — even a minor typo fails deployments.

❌ Issue 6: Application Not Accessible After Successful Pod Deployment
Cause

Kubernetes Service type set to ClusterIP

No external exposure

Solution

Changed Service type to NodePort

type: NodePort

Lesson Learned

Healthy pods do not automatically mean external access.

❌ Issue 7: Port Mismatch Between Container and Kubernetes Service
Cause

Application running on port 3000

Kubernetes Service exposing port 80

Solution

Matched containerPort and targetPort

containerPort: 3000
targetPort: 3000

Lesson Learned

Port mismatch is a very common Kubernetes production issue.

❌ Issue 8: Prometheus Pods Running but No Metrics in Grafana
Symptom

Prometheus and Grafana pods running

Grafana dashboards empty / “No data”

Cause

Prometheus not scraping Kubernetes targets

Incorrect prometheus.yml scrape configuration

Solution

Verified scrape configs

Ensured Kubernetes service discovery was enabled

Restarted Prometheus after config update

Lesson Learned

Prometheus running ≠ metrics collected.

❌ Issue 9: Grafana UI Accessible but No Dashboards Visible
Cause

Grafana installed without importing dashboards

Prometheus data source not added

Solution

Added Prometheus as Grafana data source

Imported Kubernetes dashboards (e.g. Node / Pod metrics)

Lesson Learned

Grafana is only a visualization layer — data sources must be configured manually.

❌ Issue 10: Grafana Showing Data but Not Application Metrics
Cause

Application not exposing metrics endpoint

Prometheus scraping only node-level metrics

Solution

Confirmed metrics endpoint (future enhancement)

Verified cluster-level monitoring working first

Lesson Learned

Infra metrics and application metrics are separate concerns.

❌ Issue 11: Monitoring Stack Consumed High Resources
Cause

Default Prometheus + Grafana values

No resource limits set

Solution

Identified need for resource limits (planned optimization)

Monitoring confirmed functional before optimization

Lesson Learned

Monitoring tools must be resource-tuned in real clusters.

✅ Current Project Status (Updated)
Component	Status
Azure DevOps CI Pipeline	✅ Stable
Docker Build & Push	✅ Working
Kubernetes Deployment	✅ Successful
Service Exposure	✅ Verified
Prometheus Monitoring	✅ Working
Grafana Dashboards	✅ Visible
Cluster Metrics	✅ Available


