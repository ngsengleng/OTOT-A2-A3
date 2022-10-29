#!/usr/bin/env bash
echo
echo "Creating kind cluster"
echo
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml

echo
echo "Check if cluster is up"
echo
kubectl cluster-info
kubectl get nodes

echo
echo "Load default nginx image to cluster"
echo
kind load docker-image mynginx_image1 --name kind-1

echo "Deploy backend"
echo
kubectl apply -f ./k8s/manifests/k8s/backend-deployment.yaml

echo "Create ingress controller"
echo
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Check if ingress controller is deployed"
echo
kubectl -n ingress-nginx get deploy

echo "Create service"
echo
kubectl apply -f ./k8s/manifests/k8s/backend-service.yaml

echo
echo "check service status"
echo
kubectl get svc

echo
echo "Create ingress object"
echo
kubectl apply -f ./k8s/manifests/k8s/backend-ingress.yaml

echo
echo "check ingress"
echo
kubectl get ingress
