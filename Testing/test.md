mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
yum repolist all | grep mysql

https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/
yum -y install libaio1 libmecab2