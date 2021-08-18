#!/bin/bash

##########################################################################################
# SECTION 1: PREPARE

# change root
sudo -i
sleep 2

# update system
# yum clean all
# yum -y update
# sleep 1

# config timezone
timedatectl set-timezone Asia/Ho_Chi_Minh

# disable SELINUX
setenforce 0 
sed -i 's/enforcing/disabled/g' /etc/selinux/config

# disable firewall
systemctl stop firewalld
systemctl disable firewalld

# config hostname
# hostnamectl set-hostname node2

# config file host
# cat >> "/etc/hosts" <<EOL
# 172.20.10.225 db1
# 172.20.10.226 db2
# 172.20.10.227 db3
# 172.20.10.228 db4
# 172.20.10.229 db5
# EOL

# config network, config in vagrantfile in test evironment

##########################################################################################
# SECTION 2: INSTALL 

# A. Download the MySQL Cluster software
yum install wget -y
cd ~
wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar
tar -xvf MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar

# B. Install and Remove Packages
# Before you install the rpm package for MySQL Cluster, you need to install perl-Data-Dumper that is required by the MySQL-Cluster server. 
# And you need to remove mariadb-libs before we can install MySQL Cluster.
yum -y install perl-Data-Dumper
yum -y remove mariadb-libs

# C. Install MySQL Cluster
# Install MySQL Cluster package with these rpm commands:

yum -y install MySQL-Cluster-client-gpl-7.4.10-1.el7.x86_64.rpm
yum -y install MySQL-Cluster-server-gpl-7.4.10-1.el7.x86_64.rpm
yum -y install MySQL-Cluster-shared-gpl-7.4.10-1.el7.x86_64.rpm


#########################################################################################
# SECTION 3: Configure MySQL Cluster

# Step 1
# Create a new configuration file in the /etc directory with the vi editor:
cat >> "/etc/my.cnf" <<EOF
[mysqld]
ndbcluster
ndb-connectstring=172.20.10.225     # IP address of Management Node
 
[mysql_cluster]
ndb-connectstring=172.20.10.225     # IP address of Management Node
EOF

# Step 2: Then create the new directory for the database data that
# we defined in the management node config file "config.ini".
mkdir -p /var/lib/mysql-cluster

# Step 3: Now start the data node/ndbd:
ndbd

# Step 4 : Data Node db2 connected to the management node ip 172.20.10.225 

#########################################################################################
# SECTION 4: FINISHED
echo "INSTALLATION COMPLETE COMPLETELY"