docker rmi ramesesinc/cloud-fileserver:beta -f

docker system prune -f

docker build --build-arg DOCKER_ENV=production -t ramesesinc/cloud-fileserver:beta --rm .

