#!/bin/bash

# mount shared folder
/usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other
# export envvars
export DEBIAN_FRONTEND=noninteractive
export HDUSER=hadoop$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep -v hadoop)
username=$HDUSER
password=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)

# edit hadoop user's bashrc
echo -e "\n" >> /home/$HDUSER/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64' >> /home/$HDUSER/.bashrc
echo "export HADOOP_HOME=/home/$HDUSER/hadoop" >> /home/$HDUSER/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> /home/$HDUSER/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/sbin' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_YARN_HOME=$HADOOP_HOME' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >> /home/$HDUSER/.bashrc
echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"' >> /home/$HDUSER/.bashrc

source /home/$HDUSER/.bashrc

# append mapred-site.xml
sed -i 's@<configuration>@@g' /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
sed -i 's@</configuration>@@g' /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.framework.name</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <value>yarn</value>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.application.classpath</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml

# append yarn-site.xml
sed -i 's@<configuration>@@g' /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
sed -i 's@</configuration>@@g' /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.nodemanager.aux-services</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <value>mapreduce_shuffle</value>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.nodemanager.env-whitelist</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
