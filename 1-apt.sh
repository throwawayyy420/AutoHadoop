#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt -y update
apt -y upgrade
apt -y install default-jdk ssh openssh-server open-vm-tools open-vm-tools-desktop
mkdir /mnt/hgfs
/usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other
reboot