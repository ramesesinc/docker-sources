docker rmi ramesesinc/cloud-fileserver:0.2.0 -f

docker system prune -f

docker build --build-arg DOCKER_ENV=production -t ramesesinc/cloud-fileserver:0.2.0 --rm .

