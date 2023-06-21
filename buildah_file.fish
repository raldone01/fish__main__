#!/bin/fish

# Start from the alpine image
set -l container (buildah from alpine)

# Get a mount point for the container filesystem
set -l mnt (buildah mount $container)

mkdir -p $mnt/root/.config/fish/

# Copy config.fish and my_functions into the container filesystem
cp config.fish $mnt/root/.config/fish/
cp -r my_functions $mnt/root/.config/fish/

# Run the apk add command
buildah run $container apk add fish

# Set the entrypoint
buildah config --entrypoint '["fish", "-i"]' --cmd="" $container

buildah config --env DOCKER_CONTAINER=1 $container

# Commit the image
buildah commit $container fish-main

# Unmount and remove the container
buildah unmount $container
buildah rm $container
