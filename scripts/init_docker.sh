#!/bin/bash
MAX_CACHE_AGE=604800 # seconds
DOCKER_REPO=${DOCKER_REPO:-postgrest}

if [[ -e ~/.docker/image.tar ]]; then 
	docker load --input ~/.docker/image.tar; 
	docker images -a --digests;
fi

let "AGE=$(date --date=$(docker inspect -f={{.Created}} ${DOCKER_REPO}dev) +%s)";
if [[ $MAX_CACHE_AGE -lt $AGE ]]; then
	rm -rf ~/.docker;
fi

if [[ ! -e ~/.docker/image.tar ]]; then 
	docker-compose build development; 
	docker images -a --digests;

	mkdir -p ~/.docker; 
	docker save ${DOCKER_REPO}dev > ~/.docker/image.tar;
fi
