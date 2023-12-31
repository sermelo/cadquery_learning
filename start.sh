#!/usr/bin/env bash
version="1.0"
image_name="sermelo/cadquery_jupyter:${version}"
name="cadquery_jupyter_${version}"

if [ "$(docker ps -a -q -f name=${name})" ]; then
    echo "Docker container already exist"
    if [ "$(docker ps -aq -f status=exited -f name=${name})" ]; then
        echo "Starting the container"
        docker start ${name}
    else
        echo "Container already running"
    fi
else
    echo "Starting a new container"
    docker run \
        --detach \
        --name ${name} \
        --volume ${PWD}/Workspace:/home/jovyan/Workspace \
        --publish 8888:8888 \
        --env JUPYTER_TOKEN="easy" \
        ${image_name}
fi
