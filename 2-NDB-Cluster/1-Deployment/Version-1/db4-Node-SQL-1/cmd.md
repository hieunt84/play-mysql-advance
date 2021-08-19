### commands
    service mysql start
    mysqld_safe &

### Tiếp tục cấu hình sau khi chạy kịch bản triển khai
    cd ~
    cat .mysql_secret
    mysql_secure_installation
    mysql -u root -p

    msql>CREATE USER 'root'@'%' IDENTIFIED BY 'Abcxx';
    select user, host, password from mysql.user;

    msql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*FE05E6547C26C426BE73C86246FEB4C9638679A1' WITH GRANT OPTION;

    msql>CREATE DATABASE clustertest;

    msql>USE clustertest;

    msql>CREATE TABLE test_table (name VARCHAR(20), value VARCHAR(20)) ENGINE=ndbcluster;

    msql>INSERT INTO test_table (name,value) VALUES('some_name','some_value');

    msql>SELECT * FROM test_table;