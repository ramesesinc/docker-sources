#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client:dev.001
docker build -t ramesesinc/gdx-client:dev.001 .
echo ""
echo "[gdx-client] finished."
