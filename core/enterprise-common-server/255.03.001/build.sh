#!/bin/sh
echo "[enterprise-common-server] build..."
docker rmi -f ramesesinc/enterprise-common-server:255.03.001
docker build -t ramesesinc/enterprise-common-server:255.03.001 .
echo ""
echo "[enterprise-common-server] finished."
