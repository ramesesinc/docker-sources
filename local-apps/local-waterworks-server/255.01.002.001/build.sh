#!/bin/sh
echo "[local-waterworks-server-255.01.002.001] build..."
docker rmi -f ramesesinc/local-waterworks-server:255.01.002.001
docker build -t ramesesinc/local-waterworks-server:255.01.002.001 .
echo ""
echo "[local-waterworks-server-255.01.002.001] finished."
