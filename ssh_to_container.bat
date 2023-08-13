@echo off

REM Check if ssh directory exists
if not exist .\ssh (
    echo SSH directory does not exist.
    exit /b 1
)

REM Check if id_rsa file exists
if not exist .\ssh\id_rsa (
    echo id_rsa file does not exist.
    exit /b 1
)

REM Remove localhost entries from known_hosts
ssh-keygen -R localhost

REM Execute SSH command
ssh -i .\ssh\id_rsa root@localhost -p 2222
