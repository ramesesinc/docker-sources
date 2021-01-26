docker rmi ramesesinc/cloud-gdx-node:1.0.0

docker system prune -f

docker build -t ramesesinc/cloud-gdx-node:1.0.0 --rm .

