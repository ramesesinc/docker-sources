docker container stop cloud-docs-server 

docker container rm cloud-docs-server

docker run -it -d \
    --name cloud-docs-server \
    -p 4000:4000 \
    ramesesinc/cloud-docs-server:1.0.0 \
    node server.js
