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
# 172.20.10.229 db6
# EOL

# config network, config in vagrantfile in test evironment

##########################################################################################
# SECTION 2: INSTALL 

# A. Download the MySQL Cluster software
# install EPEL repo
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# install wget
yum install wget -y

# download mysql-cluster-community
cd ~
wget -q http://172.20.10.2/mysql-cluster-community-7.6.18-1.el7.x86_64.rpm-bundle.tar
tar -xvf mysql-cluster-community-7.6.18-1.el7.x86_64.rpm-bundle.tar

# B. Install and Remove Packages
# Before you install the rpm package for MySQL Cluster, you need to install perl-Data-Dumper that is required by the MySQL-Cluster server. 
# And you need to remove mariadb-libs before we can install MySQL Cluster.
yum -y install perl-Data-Dumper
yum -y remove mariadb-libs

# C. Install MySQL Cluster
# Install MySQL Cluster package with these rpm commands:

yum -y install mysql-cluster-community-common-7.6.18-1.el7.x86_64.rpm
#rpm -Uvh mysql-cluster-community-common-7.6.18-1.el7.x86_64.rpm

yum -y install mysql-cluster-community-libs-7.6.18-1.el7.x86_64.rpm
#rpm -Uvh mysql-cluster-community-libs-7.6.18-1.el7.x86_64.rpm

yum -y install mysql-cluster-community-client-7.6.18-1.el7.x86_64.rpm
#rpm -Uvh mysql-cluster-community-client-7.6.18-1.el7.x86_64.rpm

yum -y install mysql-cluster-community-management-server-7.6.18-1.el7.x86_64.rpm
#rpm -Uvh mysql-cluster-community-management-server-7.6.18-1.el7.x86_64.rpm

#########################################################################################
# SECTION 3: Configure MySQL Cluster

# Step 1
# Create a new directory for the configuration files. I will use the "/var/lib/mysql-cluster" directory.
mkdir -p /var/lib/mysql-cluster

# Step 2
# Then create new configuration file for the cluster management named "config.ini" in the mysql-cluster directory.
cat >> "/var/lib/mysql-cluster/config.ini" <<EOF

[ndb_mgmd default]
# Directory for MGM node log files
DataDir=/var/lib/mysql-cluster
 
[ndb_mgmd]
#Management Node db1
HostName=172.20.10.225

[ndb_mgmd]
#Management Node db6
HostName=172.20.10.230
 
[ndbd default]
NoOfReplicas=2      # Number of replicas
DataMemory=256M     # Memory allocate for data storage

#Directory for Data Node
DataDir=/var/lib/mysql-cluster
 
[ndbd]
#Data Node db2
HostName=172.20.10.226
 
[ndbd]
#Data Node db3
HostName=172.20.10.227
 
[mysqld]
#SQL Node db4
HostName=172.20.10.228
 
[mysqld]
#SQL Node db5
HostName=172.20.10.229
EOF

# Step 3: Start the Management Node
ndb_mgmd --config-file=/var/lib/mysql-cluster/config.ini

#########################################################################################
# SECTION 4: FINISHED
echo "INSTALLATION COMPLETE COMPLETELY"