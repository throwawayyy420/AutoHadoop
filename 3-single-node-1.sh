#!/bin/bash

# mount shared folder
/usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other

# export envvars
export DEBIAN_FRONTEND=noninteractive
export HDUSER=hadoop$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep -v hadoop)
username=$HDUSER
password=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)

# add hadoop user
adduser --gecos "" --disabled-password $username
chpasswd <<<"$username:$password"

# download hadoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
tar -xzf hadoop-3.3.4.tar.gz
mv hadoop-3.3.4 hadoop
mv hadoop /home/$HDUSER/
chown -R $HDUSER: /home/$HDUSER
chown -R $HDUSER: /home/$HDUSER/hadoop

# config hadoop-env.sh
sed -i 's@# export JAVA_HOME=@export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64@g' /home/$HDUSER/hadoop/etc/hadoop/hadoop-env.sh

# config ssh
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
mv ~/.ssh/ /home/$HDUSER/
cat /home/$HDUSER/.ssh/id_rsa.pub >> /home/$HDUSER/.ssh/authorized_keys
chmod 600 /home/$HDUSER/.ssh/authorized_keys
chown -R $HDUSER: /home/$HDUSER/.ssh

# append core-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <name>fs.defaultFS</name>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <value>hdfs://localhost:9000</value>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml

# append hdfs-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <name>dfs.replication</name>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <value>1</value>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
