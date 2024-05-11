#!/bin/bash

# export envvars
export DEBIAN_FRONTEND=noninteractive
export HDUSER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep hadoop)

# create tmp dir
mkdir /home/$HDUSER/tmp
chown $HDUSER: /home/$HDUSER/tmp

# append core-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <name>hadoop.tmp.dir</name>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo "        <value>/home/$HDUSER/tmp</value>" >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <description>Temporary Directory.</description>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <name>fs.defaultFS</name>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo "        <value>hdfs://$HOSTNAME:9000</value>" >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '        <description>Use HDFS as file storage engine</description>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/core-site.xml

# append mapred-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.application.classpath</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.jobtracker.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo "        <value>$HOSTNAME:9001</value>" >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <description>The host and port that the MapReduce job tracker runs at. If "local", then jobs are run in-process as a single map and reduce task.</description>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.framework.name</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <value>yarn</value>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <description>The framework for running mapreduce jobs</description>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>yarn.app.mapreduce.am.env</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo "        <value>HADOOP_MAPRED_HOME=/home/$HDUSER/hadoop</value>" >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.map.env</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo "        <value>HADOOP_MAPRED_HOME=/home/$HDUSER/hadoop</value>" >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '        <name>mapreduce.reduce.env</name>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo "        <value>HADOOP_MAPRED_HOME=/home/$HDUSER/hadoop</value>" >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/mapred-site.xml

# append hdfs-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <name>dfs.replication</name>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <value>2</value>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <name>dfs.namenode.name.dir</name>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo "        <value>/home/$HDUSER/hadoop/hadoop_data/hdfs/namenode</value>" >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '        <name>dfs.datanode.data.dir</name>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo "        <value>/home/$HDUSER/hadoop/hadoop_data/hdfs/datanode</value>" >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/hdfs-site.xml

# append yarn-site.xml
sed -i '/<configuration>/,/<\/configuration>/d' /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '<configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.nodemanager.aux-services</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <value>mapreduce_shuffle</value>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.nodemanager.env-whitelist</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.resourcemanager.scheduler.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>$HOSTNAME:9002</value>" >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.resourcemanager.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>$HOSTNAME:9003</value>" >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.resourcemanager.webapp.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>$HOSTNAME:9004</value>" >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.resourcemanager.resource-tracker.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>$HOSTNAME:9005</value>" >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    <property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '        <name>yarn.resourcemanager.admin.address</name>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo "        <value>$HOSTNAME:9006</value>" >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '    </property>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml
echo '</configuration>' >> /home/$HDUSER/hadoop/etc/hadoop/yarn-site.xml

# edit workers
export HDWORKER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | grep -v hadoop)-slave1
echo "$HDWORKER" > /home/$HDUSER/hadoop/etc/hadoop/workers
