### Ref
    https://dev.mysql.com/doc/mysql-cluster-excerpt/5.7/en/mysql-cluster-basics.html

    ---
    https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster.html
    https://dev.mysql.com/doc/mysql-cluster-manager/8.0/en/mcm-terminology.html
    https://www.mysql.com/products/cluster/    
    https://dev.mysql.com/doc/refman/5.6/en/linux-installation-rpm.html
    https://dev.mysql.com/doc/mysql-cluster-excerpt/5.6/en/mysql-cluster-install-linux-rpm.html
    https://downloads.mysql.com/tutorials/cluster/mysql_wp_cluster_quickstart.pdf
    http://mysqlhighavailability.com/mysql-cluster-7-3-auto-installer/    


Management clients.  These clients connect to the management server and provide commands for starting and stopping nodes gracefully, starting and stopping message tracing (debug versions only), showing node versions and status, starting and stopping backups, and so on. An example of this type of program is the ndb_mgm management client supplied with NDB Cluster (see Section 5.5, “ndb_mgm — The NDB Cluster Management Client”). Such applications can be written using the MGM API, a C-language API that communicates directly with one or more NDB Cluster management servers. For more information, see The MGM API.
  
  ndb_mgm hay sử dụng

Oracle also makes available MySQL Cluster Manager, which provides an advanced command-line interface simplifying many complex NDB Cluster management tasks, such restarting an NDB Cluster with a large number of nodes. The MySQL Cluster Manager client also supports commands for getting and setting the values of most node configuration parameters as well as mysqld server options and variables relating to NDB Cluster. See MySQL Cluster Manager 1.4.8 User Manual, for more information. 
   - trả phí
   - Gần giống vcenter

Event logs.  NDB Cluster logs events by category (startup, shutdown, errors, checkpoints, and so on), priority, and severity. A complete listing of all reportable events may be found in Section 6.3, “Event Reports Generated in NDB Cluster”. Event logs are of the two types listed here: 


### InnoDB Cluster vs MySQL NDB Cluster
    - InnoDB Cluster: là Cluster dạng Primary-Secondary (Active-Passive)
    - MySQL NDB Cluster : là Cluster dạng Active-Active, không có node trung tâm như InnoDB Cluster
    - Tùy theo nhu cầu mà chọn Cluster loại nào.
     Important: 
       InnoDB Cluster does not provide support for MySQL NDB Cluster. NDB Cluster depends on the NDB storage engine as well as a number of programs specific to NDB Cluster which are not furnished with MySQL Server 8.0; NDB is available only as part of the MySQL NDB Cluster distribution. In addition, the MySQL server binary (mysqld) that is supplied with MySQL Server 8.0 cannot be used with NDB Cluster. For more information about MySQL NDB Cluster, see MySQL NDB Cluster 8.0. MySQL Server Using InnoDB Compared with NDB Cluster, provides information about the differences between the InnoDB and NDB storage engines.
    - Tham khảo:
      https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster-compared.html

