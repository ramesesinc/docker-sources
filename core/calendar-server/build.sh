docker rmi ramesesinc/calendar-server:0.0.1 -f

docker system prune -f

docker build --build-arg DOCKER_ENV=production -t ramesesinc/calendar-server:0.0.1 --rm .


