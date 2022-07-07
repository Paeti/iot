#!/bin/bash

sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.8 -y 

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 20
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 20

sudo apt remove python3-apt -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install python3-apt -y

export PATH="/home/ubuntu/.local/bin:$PATH"

sudo apt install pyton3-pip -y
python3 -m pip install --user pipenv

sudo rm /usr/local/cuda
sudo ln -s /usr/local/cuda-11.0 /usr/local/cuda
