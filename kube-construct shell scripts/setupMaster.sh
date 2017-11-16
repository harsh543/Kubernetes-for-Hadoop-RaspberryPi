#!/bin/bash
# Script to setup Kubernetes Master

# colors
red='\033[0;31m'
nc='\033[0m' # No Color
green='\033[0;32m'
cyan='\033[0;36m'
orange='\033[0;33m'

# formatting
bold=$(tput bold)
normal=$(tput sgr0)

echo -e "${orange}${bold}----- Initializing Master -----${nc}${normal}"

status=$(sudo dpkg-query -W -f='${Status} ${Version}\n' kubeadm)
if [[ $status != "install ok"* ]]
then
	echo -e "${red}${bold}Kubernetes not installed.${nc}${normal}"
	echo -e "${green}${bold}Installing Kubernetes.....${nc}${normal}"

	echo -e "${cyan}${bold}Trusting the kubernetes APT key and adding the official APT Kubernetes repository${nc}${normal}"
	sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

	#instaling kubeadm
	kubInstallStatus=$(sudo apt-get update && apt-get install -y kubeadm)

	echo -e "${green}${bold}Kuberenetes successfully installed${nc}${normal}"
	echo -e "${cyan}${bold}Please perform same actions on other nodes${nc}${normal}"
fi

while true; do
    read -p "Is this the master node? Yes[y/Y] or No[n/N]" yn
    case $yn in
        [Yy]* ) isMaster="yes"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ $isMaster = "yes" ]
then
	wifiName=$(sudo ifconfig wlan0|grep -Po 't addr:\K[\d.]+')

	echo -e "${cyan}${bold}--- Initializing kubeadm ---${nc}${normal}"
	sudo kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=$wifiName

	echo -e "${greeb}${bold}Initialization complete${nc}${normal}"

	echo -e "${cyan}${bold}-- Setting up cluster --${nc}${normal}"
	sudo cp /etc/kubernetes/admin.conf $HOME/
	sudo chown $(id -u):$(id -g) $HOME/admin.conf
	sudo export KUBECONFIG=$HOME/admin.conf

fi

echo -e "${green}${bold}Setup Complete${nc}${normal}"
echo -e "${cyan}${bold}Please join the other nodes using the token generated above${nc}${normal}"
