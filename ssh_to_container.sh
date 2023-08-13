#!/bin/bash

# Check if ssh directory exists
if [ ! -d ./ssh ]; then
    echo "SSH directory does not exist."
    exit 1
fi

# Check if id_rsa file exists
if [ ! -f ./ssh/id_rsa ]; then
    echo "id_rsa file does not exist."
    exit 1
fi

# Remove localhost entries from known_hosts
ssh-keygen -R localhost

# Execute SSH command
ssh -i ./ssh/id_rsa root@localhost -p 2222
