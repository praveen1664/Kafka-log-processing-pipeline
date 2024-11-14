# Building a Kafka Log Processing Pipeline with AWS EKS and Terraform

## Overview
This project demonstrates how to build a Kafka log processing pipeline using AWS EKS and Terraform. It provisions necessary AWS resources, configures an EKS cluster, and deploys a highly available Kafka cluster using ArgoCD.

### Components
- **Terraform (infra)**: Sets up VPC, EKS, DynamoDB, and ECR.
- **ArgoCD (kubernetes/argocd)**: Manages continuous deployment in the Kubernetes environment.
- **Kafka Deployment (kubernetes/kafka)**: Contains the Kafka and Zookeeper deployment manifests for Kubernetes, configured for high availability.

## Prerequisites
1. Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (v1.0+).
2. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
3. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
4. Install [Helm](https://helm.sh/docs/intro/install/) for ArgoCD setup.
5. Configure AWS CLI with appropriate IAM permissions for EKS, VPC, S3, DynamoDB, and IAM.

## Infrastructure Setup with Terraform

1. **Navigate to the `infra` directory:**

    ```bash
    cd infra
    ```

2. **Initialize and apply Terraform configuration:**

    ```bash
    terraform init
    terraform apply
    ```

    This will provision:
    - A VPC with subnets for the EKS cluster.
    - An EKS cluster.
    - A DynamoDB table for log storage.
    - An ECR repository for container images.

3. **Verify EKS Cluster Access:**

    After Terraform completes, configure `kubectl` to access the EKS cluster.

    ```bash
    aws eks update-kubeconfig --name <cluster_name> --region <region>
    ```

## Deploy ArgoCD and Kafka on EKS

### Step 1: Install ArgoCD

1. **Navigate to the `kubernetes/argocd` directory:**

    ```bash
    kubectl create namespace argocd
    kubectl apply -f kubernetes/argocd/install_argo.yaml
    ```

2. **Access the ArgoCD UI**:
    - Forward the ArgoCD server port:

        ```bash
        kubectl port-forward svc/argocd-server -n argocd 8080:443
        ```

    - Access ArgoCD at `https://localhost:8080`. Login credentials can be retrieved with:

        ```bash
        kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
        ```

### Step 2: Deploy Kafka and Zookeeper via ArgoCD

1. **Apply Kafka and Zookeeper Manifests**:

    ```bash
    kubectl apply -f kubernetes/kafka/zookeeper_deployment.yaml
    kubectl apply -f kubernetes/kafka/kafka_pvc.yaml
    kubectl apply -f kubernetes/kafka/kafka_deployment.yaml
    kubectl apply -f kubernetes/kafka/kafka_service.yaml
    ```

2. **Verify Kafka Deployment**:

    ```bash
    kubectl get pods -n kafka
    ```

## Project Cleanup
To destroy all resources created, run:

```bash
cd infra
terraform destroy