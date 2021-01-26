#!/bin/sh
echo "[cloud-obo-server] build..."
docker rmi -f ramesesinc/cloud-obo-server:v003
docker build -t ramesesinc/cloud-obo-server:v003 .
echo ""
echo "[cloud-obo-server] finished."
