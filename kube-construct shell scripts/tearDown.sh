#!/bin/bash
# Script to tear down the cluster

# colors
orange='\033[0;33m'
red='\033[0;31m'
nc='\033[0m' # No Color
green='\033[0;32m'
cyan='\033[0;36m'

# formatting
bold=$(tput bold)
normal=$(tput sgr0)

echo -e "${green}${bold}Tearing down the cluster${nc}${normal}"

if [[ $(sudo dpkg-query -W -f='${Status} ${Version}\n' kubeadm) = "install ok"* ]] > /dev/null 2>&1
then
	sudo kubeadm reset
fi

if [[ $(sudo dpkg-query -W -f='${Status} ${Version}\n' etcdctl) = "install ok"* ]] > /dev/null 2>&1
then
	sudo etcdctl rm --recursive registry
fi

sudo rm -rf /var/lib/cni
sudo rm -rf /run/flannel
sudo rm -rf /etc/cn
sudo ifconfig cni0 down > /dev/null 2>&1

if [[ $(sudo dpkg-query -W -f='${Status} ${Version}\n' brctl) = "install ok"* ]] > /dev/null 2>&1
then
	sudo brctl delbr cni0
fi

echo -e "${green}${bold}Cluster successfully cleared${nc}${normal}"
echo -e "${cyan}${bold}Ignore any errors above${nc}${normal}"
