docker rmi ramesesinc/cloud-docs-server:1.0.0 -f

docker system prune -f

docker build -t ramesesinc/cloud-docs-server:1.0.0 --rm .