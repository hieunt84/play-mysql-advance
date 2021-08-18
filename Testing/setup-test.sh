#!/bin/bash

##########################################################################################
# SECTION 1: PREPARE

# change root
sudo -i
sleep 2

# update system
yum clean all
yum -y update
sleep 1

# install EPEL repo
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y update

# config timezone
timedatectl set-timezone Asia/Ho_Chi_Minh

# disable SELINUX
setenforce 0 
sed -i 's/enforcing/disabled/g' /etc/selinux/config

# disable firewall
systemctl stop firewalld
systemctl disable firewalld

#########################################################################################
# SECTION 4: FINISHED
echo "INSTALLATION COMPLETE COMPLETELY"