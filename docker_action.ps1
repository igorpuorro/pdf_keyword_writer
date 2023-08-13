# Function to check if a resource is available
function Check-Resource {
    param (
        [string]$path,
        [string]$name
    )

    if (-not (Test-Path -Path $path)) {
        Write-Host "Error: $name not found. Cannot proceed."
        exit 1
    }
}

# Function to check the availability of necessary resources
function Check-Resources {
    Check-Resource (Get-Command docker).Path "Docker executable"
    Check-Resource "Dockerfile" "Dockerfile"
    Check-Resource "docker-compose.yml" "docker-compose.yml"
    Check-Resource "pdf_keyword_writer" "pdf_keyword_writer directory"
    Check-Resource "ssh" "ssh directory"
}

# Declare image_name variable
$image_name = "pdf-keyword-writer"

# Function to build Docker image
function Build-Image {
    # Implement your build image logic here
    docker build -t $image_name .
}

# Function to remove Docker image
function Remove-Image {
    # Implement your remove image logic here
    docker rmi $image_name
}

# Function to start Docker container
function Start-Container {
    # Implement your start container logic here
    docker-compose up -d
}

# Function to stop Docker container
function Stop-Container {
    # Implement your stop container logic here
    docker-compose down
}

# Main script
if ($args.Length -ne 1) {
    Write-Host "Usage: $MyInvocation.MyCommand <build_image|remove_image|start_container|stop_container>"
    exit 1
}

# Check resource availability before proceeding
Check-Resources

$command = $args[0]
switch ($command) {
    "build_image" {
        Build-Image
    }
    "remove_image" {
        Remove-Image
    }
    "start_container" {
        Start-Container
    }
    "stop_container" {
        Stop-Container
    }
    default {
        Write-Host "Invalid argument. Supported arguments: build_image, remove_image, start_container, stop_container"
        exit 1
    }
}

Write-Host "Action '$command' completed successfully."
