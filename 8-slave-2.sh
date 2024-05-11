#!/bin/bash

# export envvars
export DEBIAN_FRONTEND=noninteractive
export HDUSER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep hadoop)

# create tmp dir
mkdir /home/$HDUSER/tmp
chown $HDUSER: /home/$HDUSER/tmp

# append mapred-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml

# edit workers
export HDWORKER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep -v hadoop)-slave1
sed -i "s/$HDWORKER//g" /home/$HDUSER/hadoop/etc/hadoop/workers
