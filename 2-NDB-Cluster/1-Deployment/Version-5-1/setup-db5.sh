#!/bin/bash
# Instal SQL Node in NDB Cluster

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
echo "Downloading mysql-cluster-community-7.6.18-1.el7.x86_64.rpm-bundle.tar"
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

yum -y install mysql-cluster-community-server-7.6.18-1.el7.x86_64.rpm
#########################################################################################
# SECTION 3: Configure MySQL Cluster

# Step 1
# Create a new configuration file in the /etc directory with the vi editor:
cat >> "/etc/my.cnf" <<EOF
[mysqld]
# Options for mysqld process:
ndbcluster                            # run NDB storage engine
default_storage_engine=ndbcluster     # Define default Storage Engine used by MySQL
 
[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=172.20.10.225       # IP address for server management node
ndb-connectstring=172.20.10.230       # IP address for server management node
EOF

# Step 2: Start the SQL Node by starting the MySQL server
systemctl start mysqld

# Step 3: reset password
cd ~
# Get the temporary password
temp_password=$(grep password /var/log/mysqld.log | awk '{print $NF}')

# Set up a batch file with the SQL commands
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Abcqwe123@'; flush privileges;" > reset_pass.sql    

# Log in to the server with the temporary password, and pass the SQL file to it.
mysql -u root --password="$temp_password" --connect-expired-password < reset_pass.sql

# Step 4: Config
cd ~
temp_password=$(echo "Abcqwe123@")

cat >> "./config.sql" <<EOF
CREATE USER 'root'@'%' IDENTIFIED BY 'Abcqwe123@';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;
USE clustertest;
SELECT * FROM test_table;
EOF

mysql -u root --password="$temp_password" --connect-expired-password < config.sql

#########################################################################################
# SECTION 4: FINISHED
echo "INSTALLATION COMPLETE COMPLETELY"