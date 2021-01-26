#!/bin/sh
echo "[enterprise-server] build..."
docker rmi -f ramesesinc/enterprise-server:255.03
docker build -t ramesesinc/enterprise-server:255.03 .
echo ""
echo "[enterprise-server] finished."
