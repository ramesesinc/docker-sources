#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client:1.03.02
docker build -t ramesesinc/gdx-client:1.03.02 .
echo ""
echo "[gdx-client] finished."
