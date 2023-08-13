#!/bin/bash

test ! -d ./ssh && mkdir ./ssh

ssh-keygen -t rsa -b 4096 -f ./ssh/id_rsa -N ""
