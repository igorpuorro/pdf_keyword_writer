# Check if ssh directory exists
if (-not (Test-Path "ssh")) {
    Write-Host "SSH directory does not exist."
    exit 1
}

# Check if id_rsa file exists
if (-not (Test-Path "ssh\id_rsa")) {
    Write-Host "id_rsa file does not exist."
    exit 1
}

# Remove localhost entries from known_hosts
ssh-keygen.exe -R localhost

# Execute SSH command
ssh.exe -i "ssh\id_rsa" root@localhost -p 2222
