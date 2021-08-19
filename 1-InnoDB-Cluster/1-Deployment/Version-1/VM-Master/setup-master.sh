#!/bin/bash

##########################################################################################
# SECTION 1: PREPARE

# update system
sudo -i
sleep 2
yum clean all
yum -y update
sleep 1

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
# 172.16.10.100 node1
# 172.16.10.101 node2
# 172.16.10.102 node3 
# EOL

# config network, config in vagrantfile in test evironment

##########################################################################################
# SECTION 2: INSTALL 

# Install MySQL8

yum localinstall https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm -y
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld

# cấu hình secure mysql
grep "A temporary password" /var/log/mysqld.log
mysql_secure_installation

#########################################################################################
# SECTION 3: Cấu hình Replication (Master-Salve)

# Step 1
cat >> "/etc/my.cnf" <<EOF
# my-config
bind-address=172.20.10.117
server-id=1
log_bin=/var/lib/mysql/mysql-bin.log
binlog_do_db=replication_database
EOF
systemctl restart mysqld

# Step 2
mysql -u root -p
CREATE DATABASE replication_database;
CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'Abc123!@#';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
EXITS;

#########################################################################################
# SECTION 4: FINISHED

echo "installation docker complete completely"