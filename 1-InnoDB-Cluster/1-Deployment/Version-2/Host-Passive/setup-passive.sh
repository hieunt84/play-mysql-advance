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
# SECTION 3: Cấu hình Replication (Master-Salve)

# Step 1
cat >> "/etc/my.cnf" <<EOF
# my-config
bind-address=172.20.10.118
server-id=2
log_bin=/var/lib/mysql/mysql-bin.log
binlog_do_db=replication_database
relay-log=/var/lib/mysql/mysql-relay-bin.log
EOF
systemctl restart mysqld

# Set password for config
temp_password=$(echo "Abcqwe123@")

# Step 2 : cấu hình để nhân bản (replication)
cd ~
cat >> "./config-replica.sql" <<EOF
CREATE DATABASE replication_database;
CHANGE MASTER TO MASTER_HOST='172.20.10.117',
  MASTER_USER='replica_user',
  MASTER_PASSWORD='Abcqwe123@',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS= 970;
START SLAVE;
EOF

mysql -u root --password="$temp_password" --connect-expired-password < config-replica.sql

# Step 3 : Kiểm tra kết quả (verify)
cd ~
cat >> "./verify.sql" <<EOF
SHOW SLAVE STATUS\G;
EOF

mysql -u root --password="$temp_password" --connect-expired-password < verify.sql

#########################################################################################
# SECTION 4: FINISHED

echo "FINISHED"