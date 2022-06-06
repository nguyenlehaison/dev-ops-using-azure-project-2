#!/usr/bin/env bash

dockerpath="huynt32/flasksklearn"

# Run in Docker Hub container with kubernetes
kubectl run flasksklearndemo\
    --generator=run-pod/v1\
    --image=$dockerpath\
    --port=80 --labels app=flasksklearndemo

# List kubernetes pods
kubectl get pods

# Forward the container port to host
kubectl port-forward flasksklearndemo 8000:80
