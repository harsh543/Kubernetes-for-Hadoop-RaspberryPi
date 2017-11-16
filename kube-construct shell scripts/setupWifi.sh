#!/bin/bash

# colors
red='\033[0;31m'
nc='\033[0m' # No Color
green='\033[0;32m'
cyan='\033[0;36m'
orange='\033[0;33m'

# formatting
bold=$(tput bold)
normal=$(tput sgr0)


echo -e "${red}${bold}Warning: ${normal}This will delete all your previous wifi configuration just to make sure that there are no conflicts."

while true; do
    read -p "Do you wish to install this program? Yes[y/Y] or No[n/N]:" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "${orange}${bold}The current interface file will be backed up in present working directory"
yes | cp -rf /etc/network/interfaces .

while true; do
	read -p "Are you using hidden SSID? Yes[y/Y] or No[n/N]" yn
	case $yn in
	        [Yy]* ) fileType="hidden"; break;;
	        [Nn]* ) fileType="normal"; break;;
	        * ) echo "Please answer yes or no.";;
 	esac
done

read -p "Enter ssid: " ssid
read -p "Enter password: " password

if [ $fileType = "normal" ]
then
	sudo echo -e "auto lo\n\niface lo inet loopback\niface eth0 inet dhcp\n\nallow-hotplug wlan0\nauto wlan0\n\niface wlan0 inet dhcp\n\twpa-ssid \"$ssid\"\n\twpa-psk \"$password\"" > /etc/network/interfaces
fi

else
	sudo echo -e "auto lo\n\niface lo inet loopback\niface eth0 inet dhcp\n\nauto wlan0\nallow-hotplug wlan0\niface wlan0 inet dhcp\n\twpa-scan-ssid 1\n\twpa-ap-scan 1\n\twpa-key-mgmt WPA-PSK\n\twpa-proto RSN WPA\n\twpa-pairwise CCMP TKIP\n\twpa-group CCMP TKIP\n\twpa-ssid \"$ssid\"\n\twpa-psk \"$password\"\n\niface default inet dhcp" > /etc/network/interfaces
fi

echo -e "${green}${bold}Wifi successfully configured"
