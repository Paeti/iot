#!/bin/sh

echo "started"

sudo pkill --signal SIGKILL unattended-upgrades

echo "command 1"

#sudo systemctl kill --kill-who=all unattended-upgrades.service
sudo systemctl stop unattended-upgrades
#sudo systemctl disable unattended-upgrades.service

echo "command 2"

#sudo systemctl stop apt-daily.timer
#sudo systemctl stop apt-daily.service
#sudo systemctl stop apt-daily-upgrade.timer
#sudo systemctl stop apt-daily-upgrade.service

sudo apt update -y

sudo apt install software-properties-common -y
sudo apt remove unattended-upgrades -y

sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt install gcc-9 g++-9 -y

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 20

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.8 python3.8-dev -y

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 20
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 20

sudo apt install python3-pip -y
python3 -m pip install --user pipenv

sudo apt remove python3-apt -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install python3-apt -y

export PATH="/home/ubuntu/.local/bin:$PATH"

# sudo apt install pyton3-pip -y
# python3 -m pip install --user pipenv

sudo rm /usr/local/cuda
sudo ln -s /usr/local/cuda-11.0 /usr/local/cuda

pipenv install -v
