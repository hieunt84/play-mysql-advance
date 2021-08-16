### Ref
    https://viblo.asia/p/huong-dan-cai-dat-va-cau-hinh-co-ban-mysql-replication-JQVkVQgNeyd
    https://viblo.asia/p/lam-the-nao-de-setup-master-slave-replication-in-mysql-RnB5pyXdKPG
    https://www.digitalocean.com/community/tutorials/how-to-set-up-replication-in-mysql
    
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
      VM01: Master : 172.20.10.117 /root/Abc123!@#    
      VM02: Slave : 172.20.10.118

### Deploy
    1. Create script setup-master.sh
    2. Create script setup-slave.sh



