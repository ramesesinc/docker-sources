#!/bin/sh
echo "[filipizen-web:v001] build..."
docker rmi -f ramesesinc/filipizen-web:v001
docker build -t ramesesinc/filipizen-web:v001 .
echo "[filipizen-web:v001] finished."
