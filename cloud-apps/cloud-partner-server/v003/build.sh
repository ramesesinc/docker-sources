#!/bin/sh
echo "[cloud-partner-server] build..."
docker rmi -f ramesesinc/cloud-partner-server:v003
docker build -t ramesesinc/cloud-partner-server:v003 .
echo ""
echo "[cloud-partner-server] finished."
