#!/bin/sh
echo "[jasper-server:1.0] build..."
docker rmi -f ramesesinc/jasper-server:1.0
docker build -t ramesesinc/jasper-server:1.0 .
echo ""
echo "[jasper-server:1.0] finished."
