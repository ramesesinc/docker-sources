#!/bin/sh
echo "[gdx-client] build..."
docker rmi -f ramesesinc/gdx-client-core:1.03
docker build -t ramesesinc/gdx-client-core:1.03 .
echo ""
echo "[gdx-client] finished."
