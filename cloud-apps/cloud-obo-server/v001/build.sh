#!/bin/sh
echo "[cloud-obo-server] build..."
docker rmi -f ramesesinc/cloud-obo-server:v001
docker build -t ramesesinc/cloud-obo-server:v001 .
echo ""
echo "[cloud-obo-server] finished."
