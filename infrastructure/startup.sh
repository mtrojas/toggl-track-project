#!/bin/bash
sudo apt-get update && apt update && apt-get upgrade -y && apt upgrade -y && apt-get dist-upgrade -y && apt dist-upgrade -y
sudo apt-get autoclean && apt autoclean && apt-get clean && apt clean && apt-get autoremove --purge -y && apt autoremove --purge -y
wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
tar -xzvf go1.16.4.linux-amd64.tar.gz

reboot