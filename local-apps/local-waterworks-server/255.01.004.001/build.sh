#!/bin/sh
echo "[local-waterworks-server] build..."
docker rmi -f ramesesinc/local-waterworks-server:255.01.004.001
docker build -t ramesesinc/local-waterworks-server:255.01.004.001 .
echo ""
echo "[local-waterworks-server] finished."
