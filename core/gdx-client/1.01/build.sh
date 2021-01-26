#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client:1.01.005
docker build -t ramesesinc/gdx-client:1.01.005 .
echo ""
echo "[gdx-client] finished."
