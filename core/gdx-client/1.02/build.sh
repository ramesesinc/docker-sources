#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client:1.02.001
docker build -t ramesesinc/gdx-client:1.02.001 .
echo ""
echo "[gdx-client] finished."
