#!/bin/sh
echo "[enterprise-server] build..."
docker rmi -f ramesesinc/enterprise-server:255.05
docker build -t ramesesinc/enterprise-server:255.05 .
echo ""
echo "[enterprise-server] finished."
