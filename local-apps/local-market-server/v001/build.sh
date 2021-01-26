#!/bin/sh
echo "[local-market-server] build..."
docker rmi -f ramesesinc/local-market-server:v001
docker build -t ramesesinc/local-market-server:v001 .
echo ""
echo "[local-market-server] finished."
