#!/bin/sh
echo "[local-obo-server] build..."
docker rmi -f ramesesinc/local-obo-server:255.01.003.003
docker build -t ramesesinc/local-obo-server:255.01.003.003 .
echo ""
echo "[local-obo-server] finished."
