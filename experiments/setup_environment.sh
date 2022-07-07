#!/bin/bash

sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.8 -y 

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 20
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 20

python3 -m pip install --user pipenv
