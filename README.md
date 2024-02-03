# Sample Web App on Kubernetes Minikube

## Installation

### Minikube 

We will be deploying our sample web app on a minikube cluster on Ubuntu, assumed Docker is installed on you're system [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/), first we will install minikube:

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    install minikube-linux-amd64 /usr/local/bin/minikube
    minikube start --driver=docker
    sudo usermod -aG docker $USER && newgrp docker

Install kubectl:-

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

### Build Docker Image

Before building the image, we need to run the following command to make the local docker images visible to minikube:

    eval $(minikube docker-env) 

build the docker image:

    docker build -t sample_app:latest .

### Running on Minikube

For Minikube I created Deployment, Service and Ingress in order to get external access to the service. This example requires the Minikube ingress addon enabled:

Enable ingress and create Ingress controller:

    minikube addons enable ingress

Now to create the kubernetes resources run the following command:

    kubectl create -f ./kubernetes/
    curl http://$(minikube ip):80
    