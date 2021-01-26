#!/bin/sh
echo "[enterprise-server] build..."
docker rmi -f ramesesinc/enterprise-server:255.04
docker build -t ramesesinc/enterprise-server:255.04 .
echo ""
echo "[enterprise-server] finished."
