#!/usr/bin/env bash

echo
echo "start metric server"
echo
kubectl apply -f ./k8s/manifests/k8s/metric-server.yaml

echo
echo "start hpa"
echo
kubectl apply -f ./k8s/manifests/k8s/backend-hpa.yaml

echo
echo "check hpa status"
echo
kubectl get hpa

echo
echo "start zone aware deployment"
echo 
kubectl apply -f ./k8s/manifests/k8s/backend-deployment-zone-aware.yaml

echo
echo "check distribution of pods"
echo
kubectl get po -lapp=backend-zone-aware -owide --sort-by='.spec.nodeName'
