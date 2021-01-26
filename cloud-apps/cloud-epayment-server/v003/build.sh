#!/bin/sh
echo "[cloud-epayment-server] build..."
docker rmi -f ramesesinc/cloud-epayment-server:v003
docker build -t ramesesinc/cloud-epayment-server:v003 .
echo ""
echo "[cloud-epayment-server] finished."
