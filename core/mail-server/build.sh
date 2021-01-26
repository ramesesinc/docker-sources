#!/bin/sh
echo "[mail-server] build..."
docker rmi -f ramesesinc/mail-server
docker build -t ramesesinc/mail-server .
echo ""
echo "[mail-server] finished."
