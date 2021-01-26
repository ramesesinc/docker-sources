#!/bin/sh
echo "[local-epayment-server] build..."
docker rmi -f ramesesinc/local-epayment-server:2.5.01.02.03
docker build -t ramesesinc/local-epayment-server:2.5.01.02.03 .
echo ""
echo "[local-epayment-server] finished."
