#!/bin/sh
echo "[local-vehicle-server-255.01.003.002] build..."
docker rmi -f ramesesinc/local-vehicle-server:255.01.003.002
docker build -t ramesesinc/local-vehicle-server:255.01.003.002 .
echo ""
echo "[local-vehicle-server-255.01.003.002] finished."
