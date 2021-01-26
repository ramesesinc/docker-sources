#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client:v001
docker build -t ramesesinc/gdx-client:v001 .
echo ""
echo "[gdx-client] finished."
