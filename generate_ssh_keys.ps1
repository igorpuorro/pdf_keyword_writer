if (!(Test-Path -Path "./ssh" -PathType Container)) {
    New-Item -Path "./ssh" -ItemType Directory
}

ssh-keygen -t rsa -b 4096 -f "./ssh/id_rsa" -N ""
