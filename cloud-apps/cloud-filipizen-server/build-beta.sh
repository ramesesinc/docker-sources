docker rmi ramesesinc/cloud-filipizen-server:beta.04 -f

docker system prune -f

docker build --build-arg DOCKER_ENV=production -t ramesesinc/cloud-filipizen-server:beta.04 --rm .

