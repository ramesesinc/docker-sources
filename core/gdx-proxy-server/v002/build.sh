#!/bin/sh
echo "[gdx-proxy-server] build..."
docker rmi -f ramesesinc/gdx-proxy-server:v002
docker build -t ramesesinc/gdx-proxy-server:v002 .
echo ""
echo "[gdx-proxy-server] finished."
