docker container stop cloud-gdx-node

docker container rm cloud-gdx-node

docker run -it -d \
	--name cloud-gdx-node \
	-p 3000:3000 \
	--network apps_default \
	--link redis \
	-e REDIS_URL=redis://redis \
	-v /home/rameses/apps/cloud-gdx-node:/home/rameses/server:ro \
	cloud-gdx-node:1.0.0 \
	node server.js

