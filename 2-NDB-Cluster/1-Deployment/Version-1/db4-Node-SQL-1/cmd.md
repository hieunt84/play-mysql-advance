### commands
    service mysql start
    mysqld_safe &

    cd ~
    cat .mysql_secret
    mysql_secure_installation
    mysql -u root -p
    CREATE USER 'root'@'%' IDENTIFIED BY 'Abcxx';
    select user, host, password from mysql.user;

    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*FE05E6547C26C426BE73C86246FEB4C9638679A1' WITH GRANT OPTION;

    CREATE DATABASE clustertest;
    USE clustertest;
    CREATE TABLE test_table (name VARCHAR(20), value VARCHAR(20)) ENGINE=ndbcluster;
    INSERT INTO test_table (name,value) VALUES('some_name','some_value');
    SELECT * FROM test_table;