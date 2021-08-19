### Ref
    https://www.howtoforge.com/tutorial/how-to-install-and-configure-mysql-cluster-on-centos-7/#step-monitor-the-cluster

    https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04

    http://maychuchinhhang.vn/xay-dung-mot-he-thong-mysql-cluster/a9.html

    https://whitehat.vn/threads/huo%CC%81ng-da%CC%83n-ca%CC%81u-hi%CC%80nh-he%CC%A3-tho%CC%81ng-mysql-cluster.5436/

    https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-install-shutdown-restart.html

### Download
    https://downloads.mysql.com/archives/cluster/

### Version
    http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar 
    
    - Đây là bản thương mại MySQL-Cluster-7.4

### Quá trình khởi động cluster
    Hệ thống MySQL Cluster được khởi động theo trình tự sau:
    - Đầu tiên ta khởi động dịch vụ MySQL Cluster trên management node
    - Tiếp theo, ta khởi động dịch vụ MySQL Cluster trên các data node
    - Cuối cùng, ta khởi động dịch vụ MySQL Cluster trên các sql node

    1. Khởi động MySQL Cluster trên Management Node
    shell> ndb_mgmd --config-file=/var/lib/mysql-cluster/config.ini
    or
    shell> ndb_mgmd -f /var/lib/mysql-cluster/config.ini
    
    2. Khởi động MySQL Cluster trên Data Node
    shell> ndbd

    3. Khởi động MySQL Cluster trên SQL Node
    shell> /etc/init.d/mysql.server start

    4. Kiểm tra hoạt động của hệ thống MySQL Cluster sau khi khởi động trên tất cả các nodes
    - Sau khi khởi động MySQL Cluster trên tất cả các nodes, nếu quá trình cài đặt hoàn toàn chính xác, hệ thống MySQL Cluster sẽ hoạt động. 
    - Ta có thể kiểm tra trên Management Node bằng cách gọi ndb_mgm, nếu hệ thống hoạt động bình thường khi ta dùng lệnh SHOW để kiểm tra trạng thái sẽ thấy hiển thị như sau:

    shell> ndb_mgm
    -- NDB Cluster -- Management Client --
    ndb_mgm> SHOW
    Connected to Management Server at: localhost:1186
    Cluster Configuration
    ------------------------------------------
    [ndbd(NDB)]     2 node(s)
    id=2    @172.20.10.226  (mysql-5.6.28 ndb-7.4.10, Nodegroup: 0, *)
    id=3    @172.20.10.227  (mysql-5.6.28 ndb-7.4.10, Nodegroup: 0)    

    [ndb_mgmd(MGM)] 1 node(s)
    id=1    @172.20.10.225  (mysql-5.6.28 ndb-7.4.10)    

    [mysqld(API)]   2 node(s)
    id=4    @172.20.10.228  (mysql-5.6.28 ndb-7.4.10)
    id=5    @172.20.10.229  (mysql-5.6.28 ndb-7.4.10)
