#!/bin/sh

set -e

GIT_BRANCH=${GIT_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}
GIT_COMMIT_SHA1=${GIT_COMMIT_SHA1:-$(git rev-parse HEAD)}

MEATBOX_USER=${MEATBOX_USER:-meatwallace}
MEATBOX_PASSWORD=${MEATBOX_PASSWORD:-meatword}

DOCKER_NAMESPACE=${DOCKER_USER:-meatwallace}
DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME:-meatbox-alpine}
DOCKER_IMAGE_VERSION=${GIT_COMMIT_SHA1:-development}
DOCKER_IMAGE_TAG_COMMIT="$DOCKER_NAMESPACE/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION"
DOCKER_IMAGE_TAG_LATEST="$DOCKER_NAMESPACE/$DOCKER_IMAGE_NAME:latest"

echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin

docker build . \
  --build-arg "MEATBOX_USER=$MEATBOX_USER" \
  --build-arg "MEATBOX_PASSWORD=$MEATBOX_PASSWORD" \
  --build-arg "MEATBOX_CHECKOUT_SHA1=$GIT_COMMIT_SHA1" \
  --tag "$DOCKER_IMAGE_TAG_COMMIT"

docker push "$DOCKER_IMAGE_TAG_COMMIT" >/dev/null

# if we're on master, then push to latest
if [ "$GIT_BRANCH" = "master" ]; then
  docker tag "$DOCKER_IMAGE_TAG_COMMIT" "$DOCKER_IMAGE_TAG_LATEST"

  docker push "$DOCKER_IMAGE_TAG_LATEST" >/dev/null
  
  docker push "$DOCKER_IMAGE_TAG_LATEST" >/dev/null
fi
