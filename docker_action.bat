@echo off

REM Main script
if "%~1"=="" (
    echo Usage: %0 ^<build_image^|remove_image^|start_container^|stop_container^>
    exit /b 1
)

REM Declare image_name variable
set "image_name=pdf-keyword-writer"

REM Check resource availability before proceeding
set "resource_errors="
call :check_resources

if defined resource_errors (
    echo Resource check failed. Exiting.
    exit /b 1
)

if "%~1"=="build_image" (
    call :build_image
) else if "%~1"=="remove_image" (
    call :remove_image
) else if "%~1"=="start_container" (
    call :start_container
) else if "%~1"=="stop_container" (
    call :stop_container
) else (
    echo Invalid argument. Supported arguments: build_image, remove_image, start_container, stop_container
    exit /b 1
)

echo Action '%~1' completed successfully.
exit /b 0

:check_resources
REM Check if docker.exe exists in the PATH
where docker.exe > nul 2>&1
if %errorlevel% neq 0 (
    echo docker.exe not found.
    set "resource_errors=1"
)

REM Check if Dockerfile exists in the current directory
if not exist Dockerfile (
    echo Dockerfile not found.
    set "resource_errors=1"
)

REM Check if docker-compose.yml exists in the current directory
if not exist docker-compose.yml (
    echo docker-compose.yml not found.
    set "resource_errors=1"
)

REM Check if pdf_keyword_writer directory exists
if not exist pdf_keyword_writer\ (
    echo pdf_keyword_writer directory not found.
    set "resource_errors=1"
)

REM Check if ssh directory exists
if not exist ssh\ (
    echo ssh directory not found.
    set "resource_errors=1"
)

exit /b 0

REM Function to build Docker image
:build_image
docker build -t %image_name% .
goto :eof

REM Function to remove Docker image
:remove_image
docker rmi %image_name%
goto :eof

REM Function to start Docker container
:start_container
docker-compose up -d
goto :eof

REM Function to stop Docker container
:stop_container
docker-compose down
goto :eof
