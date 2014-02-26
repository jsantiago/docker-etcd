#!/bin/bash

REPO="docker-etcd"

HOST="10.0.0.10"
PORT="4001"
KEY="message"

function build {
    docker build -rm -t $REPO .
}

function run {
    docker run -rm -e HOST=$HOST -e PORT=$PORT -e KEY=$KEY -i -t $REPO
}

function cleanup {
    # Remove stopped containers
    CONTAINERS=$(docker ps  -a | grep 'Exit' | awk '{print $1}')
    if [[ -n $CONTAINERS ]]; then
        docker rm $CONTAINERS
    fi

    # Remove untagged images
    IMAGES=$(docker images | grep "^<none>" | awk '{print $3}')
    if [[ -n $IMAGES ]]; then
        docker rmi $IMAGES
    fi
}

function remove {
    IMAGE=$(docker images | grep $REPO | awk '{print $3}')
    if [[ -n $IMAGE ]]; then
        docker rmi $IMAGE
    fi
}

function usage {
    echo "Usage: $0 [build | run | cleanup | remove]"
}

while [[ -n "$1" ]]; do
    case $1 in
        -v ) shift
            MOUNT="-v $1"
            ;;
        -p ) shift
            PORT="-p $1"
            ;;
        build ) build
            ;;
        run ) run
            ;;
        cleanup ) cleanup
            ;;
        remove ) remove
            ;;
        * ) usage
            exit 1
            ;;
    esac
    shift
done
