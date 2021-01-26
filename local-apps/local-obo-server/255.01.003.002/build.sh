#!/bin/sh
echo "[local-obo-server] build..."
docker rmi -f ramesesinc/local-obo-server:255.01.003.002
docker build -t ramesesinc/local-obo-server:255.01.003.002 .
echo ""
echo "[local-obo-server] finished."
