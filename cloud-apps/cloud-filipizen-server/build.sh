docker rmi ramesesinc/cloud-filipizen-server:0.1.2 -f

docker system prune -f

docker build --build-arg DOCKER_ENV=production -t ramesesinc/cloud-filipizen-server:0.1.2 --rm .

