#!/bin/sh
echo "[enterprise-common-server] build..."
docker rmi -f ramesesinc/enterprise-common-server:255.01.004
docker build -t ramesesinc/enterprise-common-server:255.01.004 .
echo ""
echo "[enterprise-common-server] finished."
