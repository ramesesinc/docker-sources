#!/bin/sh
echo "[enterprise-core] build..."
docker rmi -f ramesesinc/enterprise-core:1.01
docker build -t ramesesinc/enterprise-core:1.01 .
echo ""
echo "[enterprise-core] finished."
