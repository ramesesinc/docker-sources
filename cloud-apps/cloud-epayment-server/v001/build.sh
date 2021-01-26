#!/bin/sh
echo "[cloud-epayment-server-v001] build..."
docker rmi -f ramesesinc/cloud-epayment-server:v001
docker build -t ramesesinc/cloud-epayment-server:v001 .
echo ""
echo "[cloud-epayment-server-v001] finished."
