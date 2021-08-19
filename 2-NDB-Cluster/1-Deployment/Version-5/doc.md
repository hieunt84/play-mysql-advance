### Info
    - Triển khai theo phiên bản cộng đồng MySQL Cluster 7.6.18
      + NDB version : ndb-7.6.18
      + MySQL Server version : mysql-5.7.34
    - quá trình cài đặt các gói có khác có khác so với bản thương mai từ version1 đến version3 trong project này.

### Tính năng
    - không cần cấu hình IndexMemory trong file cấu hình node managemnet.
    - Cấu hình thêm IP node managemnet trong file cấu hình data, sql node.

### Deploy
    - Chuẩn bị 6 vm
    - Chuẩn bị kịch bản triển khai cho mỗi vm

### Tiếp tục cấu hình sau khi triển trai phía trên 
    # Triển khai lần lượt trên db4
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
    
    # Triển khai lần lượt trên db5
    cat .mysql_secret
    mysql_secure_installation
    mysql -u root -p

    msql>CREATE USER 'root'@'%' IDENTIFIED BY 'Abcxx';
    select user, host, password from mysql.user;

    msql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*FE05E6547C26C426BE73C86246FEB4C9638679A1' WITH GRANT OPTION;

    msql>USE clustertest;
    msql>SELECT * FROM test_table;

### Quá trình khởi động cluster
    Hệ thống MySQL Cluster được khởi động theo trình tự sau:
    - Đầu tiên ta khởi động dịch vụ MySQL Cluster trên management node
    - Tiếp theo, ta khởi động dịch vụ MySQL Cluster trên các data node
    - Cuối cùng, ta khởi động dịch vụ MySQL Cluster trên các sql node

    1. Khởi động MySQL Cluster trên Management Node
    shell> ndb_mgmd -f /var/lib/mysql-cluster/config.ini  
    
    2. Khởi động MySQL Cluster trên Data Node
    shell> ndbd

    3. Khởi động MySQL Cluster trên SQL Node
    shell> systemctl start mysqld

    4. Kiểm tra hoạt động của hệ thống MySQL Cluster sau khi khởi động trên tất cả các nodes
    - Sau khi khởi động MySQL Cluster trên tất cả các nodes, nếu quá trình cài đặt hoàn toàn chính xác, hệ thống MySQL Cluster sẽ hoạt động. 
    - Ta có thể kiểm tra trên Management Node bằng cách gọi ndb_mgm, nếu hệ thống hoạt động bình thường khi ta dùng lệnh SHOW để kiểm tra trạng thái sẽ thấy hiển thị như sau:

    shell> ndb_mgm
    -- NDB Cluster -- Management Client --
    ndb_mgm> SHOW
    Connected to Management Server at: localhost:1186
    Cluster Configuration
    ---------------------
    [ndbd(NDB)]     2 node(s)
    id=3    @172.20.10.226  (mysql-5.7.34 ndb-7.6.18, Nodegroup: 0, *)
    id=4    @172.20.10.227  (mysql-5.7.34 ndb-7.6.18, Nodegroup: 0)
    
    [ndb_mgmd(MGM)] 2 node(s)
    id=1    @172.20.10.225  (mysql-5.7.34 ndb-7.6.18)
    id=2    @172.20.10.230  (mysql-5.7.34 ndb-7.6.18)
    
    [mysqld(API)]   2 node(s)
    id=5    @172.20.10.228  (mysql-5.7.34 ndb-7.6.18)
    id=6    @172.20.10.229  (mysql-5.7.34 ndb-7.6.18)
    

### Commands
    https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-mgm-client-commands.html

### Tài liệu quản trị
    https://dev.mysql.com/doc/mysql-cluster-excerpt/5.7/en/mysql-cluster-what-is-new-7-6.html
    là 1 phần của tài liệu:
    https://dev.mysql.com/doc/refman/5.7/en/

### Install repo mysql8
    ref https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/

    wget mysql80-community-release-el7-3.noarch.rpm
    sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
    yum repolist all | grep mysql

### Download 
    https://downloads.mysql.com/archives/cluster/
    https://dev.mysql.com/downloads/

### Ref
    https://www.langcongnghe.com/2018/05/huong-dan-cai-dat-va-cau-hinh-mysql-cluster-tren-he-dieu-hanh-centos-7-64bit.html
    
    https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04 


### Configuration 
    Configuration of a cluster involves configuring each individual node in the cluster and setting up individual communication links between nodes. NDB Cluster is currently designed with the intention that data nodes are homogeneous in terms of processor power, memory space, and bandwidth. In addition, to provide a single point of configuration, all configuration data for the cluster as a whole is located in one configuration file.

    The management server manages the cluster configuration file and the cluster log. Each node in the cluster retrieves the configuration data from the management server, and so requires a way to determine where the management server resides. When interesting events occur in the data nodes, the nodes transfer information about these events to the management server, which then writes the information to the cluster log.

### ndb_mgm
    ndb_mgm Client PROMPT command.  NDB Cluster 7.5 adds a new command for setting the     client's command-line prompt. The following example illustrates the use of the PROMPT     command:    

    ndb_mgm> PROMPT mgm#1:
    mgm#1: SHOW
    Cluster Configuration
    ---------------------
    [ndbd(NDB)]     4 node(s)
    id=5    @10.100.1.1  (mysql-5.7.35-ndb-7.5.24, Nodegroup: 0, *)
    id=6    @10.100.1.3  (mysql-5.7.35-ndb-7.5.24, Nodegroup: 0)
    id=7    @10.100.1.9  (mysql-5.7.35-ndb-7.5.24, Nodegroup: 1)
    id=8    @10.100.1.11  (mysql-5.7.35-ndb-7.5.24, Nodegroup: 1)    

    [ndb_mgmd(MGM)] 1 node(s)
    id=50   @10.100.1.8  (mysql-5.7.35-ndb-7.5.24)    

    [mysqld(API)]   2 node(s)
    id=100  @10.100.1.8  (5.7.35-ndb-7.5.24)
    id=101  @10.100.1.10  (5.7.35-ndb-7.5.24)    

    mgm#1: PROMPT
    ndb_mgm> EXIT
    jon@valhaj:/usr/local/mysql/bin>