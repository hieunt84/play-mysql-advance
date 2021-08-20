### Ref
    https://viblo.asia/p/huong-dan-cai-dat-va-cau-hinh-co-ban-mysql-replication-JQVkVQgNeyd
    https://viblo.asia/p/lam-the-nao-de-setup-master-slave-replication-in-mysql-RnB5pyXdKPG
    https://www.digitalocean.com/community/tutorials/how-to-set-up-replication-in-mysql
    https://www.youtube.com/watch?v=Rf2O9ix2tks
    
    
### Mục đích triển khai nhân rộng (replication)
    - sao lưu (backup)
    - tăng khả năng sẵn sàng cao (high avaibility)
    - Tăng khả năng chịu lỗi (fault-tolerance)
    - Cải thiện hiệu suất đọc và ghi (performance)
    - cách phân tích dữ liệu mà không cần sử dụng cơ sở dữ liệu chính
    - mở rộng (scale out)

### Mô hình
    - tham khảo mo-hinh-replication.png
    - Chuẩn bị hai VM
      VM01: Master : 172.20.10.117 /root/Abcxxx  
      VM02: Slave : 172.20.10.118

### Deploy
    1. Create script setup-master.sh
    2. Create script setup-slave.sh

### MySQL Router
    - Tìm hiểu mysql router dùng cho InnoDB Cluster
      https://dev.mysql.com/doc/mysql-router/8.0/en/mysql-router-general-using-developing.html

    - Chi tiết:
      https://dev.mysql.com/doc/mysql-router/8.0/en/

### Doc
    https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-innodb-cluster.html
    



