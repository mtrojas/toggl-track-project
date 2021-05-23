#! /bin/bash
apt-get update && apt update && apt-get upgrade -y && apt upgrade -y && apt-get dist-upgrade -y && apt dist-upgrade -y
apt-get autoclean && apt autoclean && apt-get clean && apt clean && apt-get autoremove --purge -y && apt autoremove --purge -y
wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
tar -xzvf go1.16.4.linux-amd64.tar.gz -C /usr/local
export PATH=$PATH:/usr/local/go/bin >> /etc/profile
reboot
