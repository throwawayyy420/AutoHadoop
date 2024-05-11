#!/bin/bash

# export envvars
export HDUSER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep hadoop)

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cat /home/$HDUSER/.ssh/id_rsa.pub >> /home/$HDUSER/.ssh/authorized_keys
chmod 600 /home/$HDUSER/.ssh/authorized_keys
# master - master
ssh-copy-id -i ~/.ssh/id_rsa.pub $HOSTNAME

# master - slave
export HDWORKER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep -v hadoop)-slave1
ssh-copy-id -i ~/.ssh/id_rsa.pub $HDWORKER