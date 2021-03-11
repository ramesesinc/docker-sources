#!/bin/sh
echo "[enterprise-common-server] build..."
docker rmi -f ramesesinc/enterprise-common-server:255.04.002
docker build -t ramesesinc/enterprise-common-server:255.04.002 .
echo ""
echo "[enterprise-common-server] finished."
