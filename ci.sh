#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" != "false" ] || [ "$TRAVIS_BRANCH" != "master" ]; then
    docker buildx build \
    --progress plain \
    --platform=$ARCHS \
    .
    exit $?
fi
if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
    TAG="${TRAVIS_TAG:-latest}"
    docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
    docker buildx build \
        --progress plain \
        --platform=$ARCHS \
        -t $DOCKER_REPO:$TAG \
        --push \
        .
fi