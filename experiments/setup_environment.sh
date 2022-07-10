#!/bin/sh

echo "started"

pkill --signal SIGKILL unattended-upgrades
ps -A | grep unattended-upgrades | awk '{print $1}' | xargs -r kill -15 $1
killall apt apt-get

echo "command 1"

#sudo systemctl kill --kill-who=all unattended-upgrades.service
systemctl stop unattended-upgrades.service
systemctl disable unattended-upgrades.service

echo "command 2"

#sudo systemctl stop apt-daily.timer
#sudo systemctl stop apt-daily.service
#sudo systemctl stop apt-daily-upgrade.timer
#sudo systemctl stop apt-daily-upgrade.service

apt update -y

killall apt apt-get

apt purge unattended-upgrades -y
apt install software-properties-common -y
#apt remove unattended-upgrades -y

add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt install gcc-9 g++-9 -y

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 20

add-apt-repository ppa:deadsnakes/ppa -y
apt install python3.8 python3.8-dev -y

update-alternatives --install /usr/bin/python python /usr/bin/python3.8 20
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 20

apt install python3-pip -y
#python3 -m pip install --user pipenv

apt remove python3-apt -y
apt autoremove -y
apt autoclean -y
apt install python3-apt -y

#export PATH="/home/ubuntu/.local/bin:$PATH"

# sudo apt install pyton3-pip -y
# python3 -m pip install --user pipenv

rm /usr/local/cuda
ln -s /usr/local/cuda-11.0 /usr/local/cuda

#pipenv install -v
