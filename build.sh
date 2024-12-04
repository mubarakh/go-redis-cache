#!/bin/bash

IMAGE_NAME="fibonacci-service"
DOCKERFILE_PATH="./Dockerfile"
BUILD_CONTEXT="."
TAG=${1:-latest}

echo "Cleaning up any previous build artifacts..."
docker system prune -f

echo "Tests passed, proceeding with Docker build."

echo "Building Docker image ${IMAGE_NAME}:${TAG}..."
docker build -t "${IMAGE_NAME}:${TAG}" -f "$DOCKERFILE_PATH" "$BUILD_CONTEXT"

echo "Tagging the Docker image for local registry..."
docker tag "${IMAGE_NAME}:${TAG}" "${IMAGE_NAME}:${TAG}"

echo "Pushing image to local registry..."
docker push "${IMAGE_NAME}:${TAG}"

echo "Pulling redis image to local registry..."
docker image pull redis

echo "Verifying the Docker image..."
docker images | grep "${IMAGE_NAME}"

echo "Build and push completed!"