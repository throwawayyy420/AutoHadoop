#!/bin/bash

# export envvars
export DEBIAN_FRONTEND=noninteractive
export HDUSER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep hadoop)
ip_addr=$(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0)
master_ip=$(awk -F"." '{print $1"."$2"."$3".1"}' <<< $ip_addr)
slave_ip=$(awk -F"." '{print $1"."$2"."$3".3"}' <<< $ip_addr)
gateway=$(awk -F"." '{print $1"."$2"."$3".2"}' <<< $ip_addr)
master=$(awk -F"-" '{print $1"-master"}' <<< $HOSTNAME)
slave=$(awk -F"-" '{print $1"-slave1"}' <<< $HOSTNAME)

# edit netplan
truncate -s 0 /etc/netplan/00-installer-config.yaml
echo "network:" >> /etc/netplan/00-installer-config.yaml
echo "  ethernets:" >> /etc/netplan/00-installer-config.yaml
echo "    ens33:" >> /etc/netplan/00-installer-config.yaml
echo "      dhcp4: false" >> /etc/netplan/00-installer-config.yaml
echo "      dhcp6: false" >> /etc/netplan/00-installer-config.yaml
echo "      addresses: [$slave_ip/24]" >> /etc/netplan/00-installer-config.yaml
echo "      routes:" >> /etc/netplan/00-installer-config.yaml
echo "        - to: default" >> /etc/netplan/00-installer-config.yaml
echo "          via: $gateway" >> /etc/netplan/00-installer-config.yaml
echo "      nameservers:" >> /etc/netplan/00-installer-config.yaml
echo "        addresses: [$slave_ip, 8.8.8.8, 8.8.4.4]" >> /etc/netplan/00-installer-config.yaml
echo "  version: 2" >> /etc/netplan/00-installer-config.yaml

netplan apply

# edit hosts
echo -e "\n" >> /etc/hosts
echo "$master_ip  $master" >> /etc/hosts
echo "$slave_ip  $slave" >> /etc/hosts

sed -i 's/127.0.0.1/# 127.0.0.1/g' /etc/hosts
sed -i 's/127.0.1.1/# 127.0.1.1/g' /etc/hosts

# edit hostname
sed -i 's/master/slave1/g' /etc/hostname
reboot