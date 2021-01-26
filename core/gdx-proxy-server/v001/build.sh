#!/bin/sh
echo "[gdx-proxy-server] build..."
docker rmi -f ramesesinc/gdx-proxy-server:v001
docker build -t ramesesinc/gdx-proxy-server:v001 .
echo ""
echo "[gdx-proxy-server] finished."
