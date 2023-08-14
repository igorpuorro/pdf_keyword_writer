# pdf_keyword_writer

A simple tool to write keywords to PDF files.

## Installing

### Linux or WSL with Python 3

1. Make sure pip3 is installed and running properly.
2. Run the following commands:

```
git clone https://github.com/igorpuorro/pdf_keyword_writer.git
cd pdf_keyword_writer/
pip3 install -r requirements.txt
```

### Docker

#### Installing with Docker on Linux

1. Run the following commands:

```
git clone https://github.com/igorpuorro/pdf_keyword_writer.git
cd pdf_keyword_writer/
./generate_ssh_keys.sh
./docker_action.sh build_image
./docker_action.sh start_container
./ssh_to_container.sh
```

#### Installing with Docker on Windows

1. Run the following commands:

```
git config --global core.autocrlf false
git clone https://github.com/igorpuorro/pdf_keyword_writer.git
cd pdf_keyword_writer
generate_ssh_keys.bat
docker_action.bat build_image
docker_action.bat start_container
ssh_to_container.bat
```

## License

This project is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives License (CC BY-NC-ND).
