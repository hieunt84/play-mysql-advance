### Script setup mysql 5.7 automatically
    https://unix.stackexchange.com/questions/476802/install-mysql-5-7-using-bash-script-with-centos

### commands
    mysql -u root --password="$temp_password" --connect-expired-password < verify.sql > file1.txt
    position=$(grep mysql ./file1.txt | awk '{print $NF}')

 