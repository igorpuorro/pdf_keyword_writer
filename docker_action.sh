#!/bin/bash

# Check if a resource is available
check_resource() {
    if [ ! -e "$1" ]; then
        echo "Error: $2 not found. Cannot proceed."
        exit 1
    fi
}

# Check the availability of necessary resources
check_resources() {
    check_resource "$(command -v docker)" "Docker executable"
    check_resource "Dockerfile" "Dockerfile"
    check_resource "docker-compose.yml" "docker-compose.yml"
    check_resource "pdf_keyword_writer" "pdf_keyword_writer directory"
    check_resource "ssh" "ssh directory"
}

# Declare image_name variable
image_name="pdf-keyword-writer"

# Function to build Docker image
build_image() {
    # Implement your build image logic here
    docker build -t "$image_name" .
}

# Function to remove Docker image
remove_image() {
    # Implement your remove image logic here
    docker rmi "$image_name"
}

# Function to start Docker container
start_container() {
    # Implement your start container logic here
    docker-compose up -d
}

# Function to stop Docker container
stop_container() {
    # Implement your stop container logic here
    docker-compose down
}

# Main script
if [ $# -ne 1 ]; then
    echo "Usage: $0 <build_image|remove_image|start_container|stop_container>"
    exit 1
fi

# Check resource availability before proceeding
check_resources

case "$1" in
    build_image)
        build_image
        ;;
    remove_image)
        remove_image
        ;;
    start_container)
        start_container
        ;;
    stop_container)
        stop_container
        ;;
    *)
        echo "Invalid argument. Supported arguments: build_image, remove_image, start_container, stop_container"
        exit 1
        ;;
esac

echo "Action '$1' completed successfully."
