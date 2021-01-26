#!/bin/sh
echo "[enterprise-server:255.02] build..."
docker rmi -f ramesesinc/enterprise-server:255.02
docker build -t ramesesinc/enterprise-server:255.02 .
echo ""
echo "[enterprise-server:255.02] finished."
