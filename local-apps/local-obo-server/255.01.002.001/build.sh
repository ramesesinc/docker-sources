#!/bin/sh
echo "[local-obo-server-255.01.002.001] build..."
docker rmi -f ramesesinc/local-obo-server:255.01.002.001
docker build -t ramesesinc/local-obo-server:255.01.002.001 .
echo ""
echo "[local-obo-server-255.01.002.001] finished."
