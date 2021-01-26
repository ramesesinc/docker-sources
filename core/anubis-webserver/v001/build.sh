#!/bin/sh
echo "[anubis-webserver:v001] build..."
docker rmi -f ramesesinc/anubis-webserver:v001
docker build -t ramesesinc/anubis-webserver:v001 .
echo ""
echo "[anubis-webserver:v001] finished."

