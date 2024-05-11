#!/bin/bash

/usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other
export DEBIAN_FRONTEND=noninteractive
sed -i 's/# PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/# PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart