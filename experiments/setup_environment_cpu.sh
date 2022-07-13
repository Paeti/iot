#!/bin/sh

pkill --signal SIGKILL unattended-upgrades
ps -A | grep unattended-upgrades | awk '{print $1}' | xargs -r kill -15 $1
killall apt apt-get

systemctl stop unattended-upgrades.service
systemctl disable unattended-upgrades.service

apt update -y

killall apt apt-get

apt purge unattended-upgrades -y
apt install software-properties-common -y
apt install cmake -y

add-apt-repository ppa:deadsnakes/ppa -y
apt install python3.9 python3.9-dev -y

update-alternatives --install /usr/bin/python python /usr/bin/python3.9 20
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 20

apt-get install python3.9-distutils -y
apt install python3-pip -y

#apt remove python3-apt -y
#apt autoremove -y
#apt autoclean -y
#apt install python3-apt -y
