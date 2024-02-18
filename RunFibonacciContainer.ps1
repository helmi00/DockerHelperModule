# Import the DockerHelper module
Import-Module ./DockerHelper.psm1

# Build the Docker image
Build-DockerImage -Dockerfile ./Dockerfile -Tag fibonacci -Context .

# Run the Docker container
$containerName = Run-DockerContainer -ImageName fibonacci

# Output the container name
Write-Output $containerName
