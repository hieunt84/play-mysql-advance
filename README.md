# play-mysql-advance
## Ref rất hay
   https://github.com/hieunt84/ghichep-database/blob/master/docs/2-replica-master-slave.md      

### mysql hỗ trợ hai dạng cluster
    1. Active-passive : InnoDB
    2. Active-Active: NDB

### Các giải pháp triển khai Clustering
    Chính chủ:
    1.InnoDB Clustering
    2.NDB Clustering

    Bên thứ ba
    1.Galera (key search google mysql cluster Galera)
       Ref: https://galeracluster.com/products/   

    2. Percona XtraDB Cluster (key search google mysql cluster XtraDB)
      - Lấy Galera làm thự viện, rồi phát triển thêm tính năng  
       Ref: https://www.percona.com/software/mysql-database/percona-xtradb-cluster

       Ref: https://sec.vnpt.vn/2021/07/12920/ 

       Ref: https://linhnh285.com/2021/04/26/cai-dat-va-cau-hinh-he-thong-mysql-cluster/

    3. DRDB
       Ref: https://vietcalls.com/xay-dung-mo-hinh-high-availability-mysql-cluster-drbd/

       Ref: https://cloud.google.com/architecture/deploying-highly-available-mysql-cluster-with-drbd-on-compute-engine

       https://linbit.com/linbit-software-download-page-for-linstor-and-drbd-linux-driver/

### Lựa chọn các giải pháp sẵn có cao của MySQL
    https://helpex.vn/article/lua-chon-cac-giai-phap-san-co-cao-cua-mysql-60a3dd993c25e7505ac52392