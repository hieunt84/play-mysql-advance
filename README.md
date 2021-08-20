# play-mysql-advance
## Ref rất hay
   https://github.com/hieunt84/ghichep-database/blob/master/docs/2-replica-master-slave.md      

### mysql hỗ trợ hai dạng cluster
    1. Active-passive : InnoDB
    2. Active-Active: NDB

### Các giải pháp triển khai Clustering
    Chính chủ:
    1.InnoDB Clustering (tích hợp sẵn)
    2.NDB Clustering (trả phí để sử dụng)

    Bên thứ ba
    1.Galera (key search google mysql cluster Galera)

    2. Percona XtraDB Cluster (key search google mysql cluster XtraDB)
      - Lấy Galera làm thự viện, rồi phát triển thêm tính năng quản lý cluster

    3. DRDB

### Lựa chọn các giải pháp sẵn có cao của MySQL
    https://helpex.vn/article/lua-chon-cac-giai-phap-san-co-cao-cua-mysql-60a3dd993c25e7505ac52392

### Lựa chọn MySQL so  với các database khác
    https://csc.edu.vn/lap-trinh-va-csdl/tin-tuc/kien-thuc-lap-trinh/vi-sao-nen-chon-mysql-5-487
    https://www.hostinger.vn/huong-dan/mysql-la-gi/
