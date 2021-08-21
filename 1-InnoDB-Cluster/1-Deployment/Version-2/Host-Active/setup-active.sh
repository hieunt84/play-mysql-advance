#!/bin/bash
# Description: Set up MySQL Community Release 5.7.35

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

##########################################################################################
# SECTION 2: INSTALL

# install EPEL repo
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# install wget
yum -y install wget

# Get the repo RPM and install it.
# home user root
cd ~
echo "Downloading mysql57-community-release-el7-7.noarch.rpm"
wget http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm 
yum -y install ./mysql57-community-release-el7-7.noarch.rpm

# Install the server and start it
yum -y install mysql-community-server 
systemctl start mysqld 
systemctl enable mysqld

# Get the temporary password
temp_password=$(grep password /var/log/mysqld.log | awk '{print $NF}')

# Set up a batch file with the SQL commands
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Abcqwe123@'; flush privileges;" > reset_pass.sql    

# Log in to the server with the temporary password, and pass the SQL file to it.
mysql -u root --password="$temp_password" --connect-expired-password < reset_pass.sql

#########################################################################################
# SECTION 3: Cấu hình Replication (Active-Passive)

# Step 1
cat >> "/etc/my.cnf" <<EOF
[mysqld]
# my-config
bind-address=172.20.10.117
server-id=1
log_bin=/var/lib/mysql/mysql-bin.log
binlog_do_db=replication_database
EOF
systemctl restart mysqld

# Set password for config
temp_password=$(echo "Abcqwe123@")

# Step 2
cd ~
cat >> "./config-replica.sql" <<EOF
CREATE DATABASE replication_database;
CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'Abcqwe123@';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
EOF
mysql -u root --password="$temp_password" --connect-expired-password < config-replica.sql

# Step 3: Verify
cd ~
cat >> "./verify.sql" <<EOF
SHOW MASTER STATUS;
EOF
mysql -u root --password="$temp_password" --connect-expired-password < verify.sql

#########################################################################################
# SECTION 4: FINISHED
echo "installation complete completely"