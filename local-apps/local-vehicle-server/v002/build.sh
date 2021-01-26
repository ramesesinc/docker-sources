#!/bin/sh
echo "[local-vehicle-server-v002] build..."
docker rmi -f ramesesinc/local-vehicle-server:v002
docker build -t ramesesinc/local-vehicle-server:v002 .
echo ""
echo "[local-vehicle-server-v002] finished."
