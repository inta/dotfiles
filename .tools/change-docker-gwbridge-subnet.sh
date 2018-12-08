#!/bin/bash

# https://success.docker.com/article/how-do-i-change-the-docker-gwbridge-address

if ! command -v docker > /dev/null; then
	echo "ERROR: docker is required but missing"
	exit 1
fi

if [ -z "$1" ]; then
	echo "Usage: $(basename "$0") <subnet e.g. 172.27.0.0/16>"
	exit 1
fi

if [[ ! "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}$ ]]; then
	echo "$1 is no valid subnet, please provide subnet in CIDR notation e.g. 172.27.0.0/16"
	exit 1
fi

subnet=$1
gateway="$(echo "$subnet" | sed -E "s/.[^.]+$/.1/")"

docker swarm join-token worker
docker swarm join-token manager

# stop classic containers
gwbridge_containers=$(docker network inspect docker_gwbridge \
	--format '{{range $k, $v := .Containers}}{{$k}}{{printf "\n"}}{{end}}' \
	| xargs -I{} docker container ls -f is-task=false -f id={} --format {{.Names}})
if [ ! -z "$gwbridge_containers" ]; then
	echo "${gwbridge_containers}"
	docker stop ${gwbridge_containers}
fi

docker swarm leave --force
docker network rm docker_gwbridge

docker network create  \
	--subnet "$subnet" \
	--gateway "$gateway" \
	-o com.docker.network.bridge.enable_icc=false \
	-o com.docker.network.bridge.name=docker_gwbridge \
	docker_gwbridge

docker network inspect docker_gwbridge \
	--format '{{range $k, $v := index .IPAM.Config 0}}{{.| printf "%s: %s " $k}}{{end}}'

docker swarm init
