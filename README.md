# AWS Cloud Resume: The Modernization Journey 🚀
### From Serverless (Lambda) to Cloud-Native (EKS)

This repository contains my personal Cloud Resume project, showcasing the evolution of a web application from a standard Serverless architecture to a robust, enterprise-grade **Kubernetes** environment.

---

## 🏗️ Phase 1: The Serverless Foundation (Legacy)
Initially, the project was built using **AWS Lambda** and **API Gateway**. This phase focused on cost-efficiency and quick deployment.

**![Architecture Phase 1 - Serverless](./architecture-diagrams/old_architecture.png)**

* **Backend:** Python Lambda functions.
* **Database:** Amazon DynamoDB.
* **Status:** Deprecated (Found in `backend/legacy-lambda/`).

---

## 🏗️ Phase 2: Kubernetes Modernization (Current)
To demonstrate scalability and advanced orchestration, I migrated the backend to **Amazon EKS (Kubernetes)**. This transition reflects modern DevOps practices and enterprise-level infrastructure.

**![Architecture Phase 2 - EKS](./architecture-diagrams/new_architecture.png)**

### **The Modern Tech Stack**
* **Frontend:** A single, optimized index.html file (with embedded JavaScript) hosted on **Amazon S3**.
* **Distribution:** **Amazon CloudFront** providing global low-latency and SSL.
* **Orchestration:** **Amazon EKS** (Managed Kubernetes).
* **IaC:** **Terraform** for full infrastructure provisioning.
* **Containerization:** **Docker** images hosted on **Amazon ECR**.
* **CI/CD**: **GitHub Actions** for automated frontend deployment.

---

## ⚙️ Automated Deployment (CI/CD)
The frontend deployment is fully automated to ensure high availability and rapid updates.
* **Workflow:** Every time the `index.html` file is modified in this repository, a **GitHub Actions** workflow is triggered.
* **AWS S3 Sync:** The workflow automatically authenticates with AWS and syncs the updated frontend files to the **Amazon S3** bucket.
* **Consistency:** This eliminates manual upload errors and ensures the live portfolio always reflects the latest codebase.

---

## 🛡️ Key Engineering Challenges & Solutions

### 1. **Zero-Trust Security with IRSA**
Instead of using long-lived AWS Access Keys, I implemented **IAM Roles for Service Accounts (IRSA)**. 
* **The Logic:** Kubernetes Pods assume temporary IAM roles via an OIDC provider.
* **The Result:** Enhanced security following the **Principle of Least Privilege**.

### 2. **Networking & Reverse Proxy Logic**
To solve **Mixed Content** issues and simplify the frontend architecture, I used **Amazon CloudFront** as a reverse proxy.
* `/` -> Routes to S3 (Static Content).
* `/visit` -> Routes to the EKS Load Balancer (Dynamic API).

### 3. **Infrastructure as Code (IaC)**
The entire AWS environment (VPC, Subnets, NAT Gateways, EKS, IAM) is managed via **Terraform** to ensure consistency and prevent configuration drift.

---

## 📁 Project Structure

* `📂 architecture-diagrams/`: Old and new architecture diagrams.
* `📂 backend/`: Python API and Docker configuration.
* `📂 backend/legacy-lambda/`: The original serverless implementation.
* `📂 infrastructure/`: Terraform modules for AWS resources.
* `📂 k8s-manifests/`: Kubernetes Deployment, Service, and ServiceAccount definitions.
* `📂 frontend/`: Contains the index.html with embedded JS logic.

---

## 🚀 Deployment Guide

1.  **Provision Infrastructure:**
    ```bash
    cd infrastructure
    terraform init && terraform apply
    ```
2.  **Apply K8s Configurations:**
    ```bash
    kubectl apply -f k8s-manifests/service-account.yaml
    kubectl apply -f k8s-manifests/deployment.yaml
    ```

---
> **Outcome:** This project demonstrates my ability to bridge the gap between software development and cloud operations, handling security, networking, and orchestration at scale.