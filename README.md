# 🚀 Jenkins Multi-Agent CI/CD on Kubernetes 🧩☸️

Welcome to a fully containerized, scalable Jenkins CI/CD system built with custom Docker images and deployed on Kubernetes! This project enables **on-demand Jenkins agents**, **parallel pipelines**, and a **secure, production-ready DevOps setup**.

---

## 📌 Project Overview

This setup demonstrates how to:

- 🧱 **Build a custom Jenkins image** with required tools
- ☸️ **Deploy Jenkins master** on a Kubernetes cluster
- 🤖 **Auto-create Jenkins agents** (pods) on-demand via Kubernetes plugin
- 🛡️ **Secure access** using Kubernetes RBAC
- ⚡ **Run parallel CI stages** using ephemeral pods

---

## 📂 Project Structure

.
├── Dockerfile # Custom Jenkins image build  
├── k8s/  
│ ├── jenkins-deployment.yaml # Kubernetes deployment for Jenkins master  
│ ├── jenkins-service.yaml # Service to expose Jenkins  
│ ├── serviceaccount.yaml # ServiceAccount, Role, RoleBinding  
├── Jenkinsfile # Example multi-agent pipeline  
└── README.md # You're here!  



---

## 🧱 Step 1: Build Custom Jenkins Image

Includes:
- 🧑‍💻 Jenkins (manual install, no prebuilt image)
- ☕ Java
- 🧰 Tools: `curl`, `wget`, `gnupg`, `fontconfig`
  
Build it:


docker build -t your-dockerhub-user/custom-jenkins .  
docker push your-dockerhub-user/custom-jenkins  
## ☸️ Step 2: Deploy Jenkins Master in Kubernetes  
Apply the Kubernetes manifests:  


kubectl apply -f k8s/jenkins-deployment.yaml  
kubectl apply -f k8s/jenkins-service.yaml  
Access Jenkins UI:  


kubectl port-forward svc/jenkins 8080:8080  
## 🔐 Step 3: RBAC for Jenkins ↔ Kubernetes  
Set up a ServiceAccount, Role, and RoleBinding:  


kubectl apply -f k8s/serviceaccount.yaml  
This allows Jenkins to talk to the Kubernetes API and spawn agent pods.  

## ⚙️ Step 4: Kubernetes Cloud Configuration in Jenkins UI  
Configure Kubernetes plugin:  

Field	Value  
Kubernetes URL	https://kubernetes.default  
Namespace	default  
Jenkins URL	http://jenkins:8080 (internal)  
Docker image	your-dockerhub-user/custom-jenkins  
Labels	jenkins-agent  
Credentials	Select ServiceAccount Token  

Add Pod Template and give container name: jnlp  

## 🤖 Step 5: Create Multi-Agent Pipeline  
Create a pipeline job with the following Jenkinsfile:  

```
pipeline {  
  agent none  
  stages {  
    stage('Parallel Tasks') {  
      parallel {  
        stage('Task 1') {  
          agent { label 'jenkins-agent' }  
          steps {  
            sh 'echo "Running Task 1"'  
            sh 'java -version'  
          }  
        }  
        stage('Task 2') {  
          agent { label 'jenkins-agent' }  
          steps {  
            sh 'echo "Running Task 2"'  
            sh 'hostname'  
          }  
        }  
      }  
    }  
  }  
}
```
🔄 This will dynamically launch two Jenkins agent pods, run the tasks, and terminate them after the job is done.  

🎯 Features  
✅ Custom-built Jenkins image  
✅ Dynamic agent pod provisioning  
✅ Scalable parallel pipelines  
✅ Secure Kubernetes integration  
✅ Clean ephemeral CI workers  

💡 Ideal Use Cases  
Microservices teams needing isolated CI runs  

Scalable pipelines in cloud-native environments  

DevOps orgs automating container workflows  

Cost-efficient CI using Kubernetes resources  

🧠 Final Thoughts  
This project demonstrates a complete infrastructure-as-code DevOps pipeline with dynamic scalability and secure resource access. Feel free to fork, star ⭐ and improve!  
