### Ref
    Doc: official
    https://dev.mysql.com/doc/mysql-cluster-manager/8.0/en/mcm-terminology.html
    https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster.html
    https://www.mysql.com/products/cluster/
    https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster.html
    https://dev.mysql.com/doc/refman/5.6/en/linux-installation-rpm.html
    https://dev.mysql.com/doc/mysql-cluster-excerpt/5.6/en/mysql-cluster-install-linux-rpm.html

    https://downloads.mysql.com/tutorials/cluster/mysql_wp_cluster_quickstart.pdf
    http://mysqlhighavailability.com/mysql-cluster-7-3-auto-installer/    
    

### Giới thiệu
    - Đây là tính năng chỉ có trong bản thương mại.
    - Phải trả phí để có tính năng này.

### Tính năng
    - Hệ thống cluster này theo kiến trúc Active-Active, không có máy chủ trung tâm (master/central).
    - Nên 01 hoặc vài máy chủ fail hệ thống vẫn hoạt động.
      Tham khảo: https://www.mysql.com/products/cluster/availability.html


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



### InnoDB Cluster vs MySQL NDB Cluster
    - InnoDB Cluster: là Cluster dạng Primary-Secondary (Active-Passive)
    - MySQL NDB Cluster : là Cluster dạng Active-Active, không có node trung tâm như InnoDB Cluster
    - Tùy theo nhu cầu mà chọn Cluster loại nào.
     Important: 
       InnoDB Cluster does not provide support for MySQL NDB Cluster. NDB Cluster depends on the NDB storage engine as well as a number of programs specific to NDB Cluster which are not furnished with MySQL Server 8.0; NDB is available only as part of the MySQL NDB Cluster distribution. In addition, the MySQL server binary (mysqld) that is supplied with MySQL Server 8.0 cannot be used with NDB Cluster. For more information about MySQL NDB Cluster, see MySQL NDB Cluster 8.0. MySQL Server Using InnoDB Compared with NDB Cluster, provides information about the differences between the InnoDB and NDB storage engines.
    - Tham khảo:
      https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster-compared.html