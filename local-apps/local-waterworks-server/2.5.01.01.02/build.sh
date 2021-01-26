#!/bin/sh
echo "[local-waterworks-server] build..."
docker rmi -f ramesesinc/local-waterworks-server:2.5.01.01.02
docker build -t ramesesinc/local-waterworks-server:2.5.01.01.02 .
echo ""
echo "[local-waterworks-server] finished."
