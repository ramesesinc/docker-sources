#!/bin/sh
echo "[local-vehicle-server-v001] build..."
docker rmi -f ramesesinc/local-vehicle-server:v001
docker build -t ramesesinc/local-vehicle-server:v001 .
echo ""
echo "[local-vehicle-server-v001] finished."
