#!/bin/sh
echo "[local-vehicle-server] build..."
docker rmi -f ramesesinc/local-vehicle-server:255.03.001.001
docker build -t ramesesinc/local-vehicle-server:255.03.001.001 .
echo ""
echo "[local-vehicle-server] finished."
