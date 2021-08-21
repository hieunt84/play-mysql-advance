## Ghi chép về các kỹ thuật/giải pháp HA cho mysql

### Mục lục:
- [1. Giới thiệu về HA cho DB ](#1)
- [2. Các giải giải pháp ](#2)
- [2.1 Giải pháp có sẵn ](#2.1)	
	- [2.1.1 Master - Slave ](#2.1.1)		
	- [2.1.2 Master - Master ](#2.1.2)	
- [2.2 Giải pháp bên thứ 3 (3rd party) ](#2.2)	
	- [2.2.1 Galera](#2.2.1)	
	- [2.2.2 DRBD ](#2.2.2)	
	- [2.2.3 Radundant Hardware ](#2.2.3)	
	- [2.2.4 Shared Storage ](#2.2.4)	
	- [2.2.5 MySQL clustering  ](#2.2.5)	
	- [2.2.6 Percona cluster  ](#2.2.6)	
- [3. Kết luận ](#3)

<a name="1"></a>

## 1. Giới thiệu về HA

Ngày nay, công nghệ thông tin đã ăn sâu vào nhiều lĩnh vực trong đời sống phục vụ cho sản xuất, giải trí và đặc biệt nhu cầu thông tin. Các hệ thống này luôn được đầu tư với quy mô càng ngày càng mở rộng, là hướng phát triển trọng tâm của doanh nghiệp cung cấp nội dung. Để đảm bảo các dịch vụ chạy thông suốt, phục vụ tối đa đến nhu cầu của người sử dụng và nâng cao tính bảo mật, an toàn dữ liệu; giải pháp High Availability được nghiên cứu và phát triển bởi nhiều hãng công nghệ lớn. Với Database, tính an toàn và khả dụng được đặt lên hàng đầu. Vì vậy, ở bài viết này, chúng tôi xin phép điểm qua một vài Giải pháp HA cho hệ cơ sở dữ liệu sử dụng MySQL hoặc MariaDB đang được cộng đồng tin dùng.

### HA giải quyết được gì?

- Tăng tính hoạt động sẵn sàng dữ liệu mọi lúc mọi nơi
- Nâng cao hiệu suất làm việc của hệ thống
- Nâng cao được tính an toàn dữ liệu
- Đảm bảo hệ thống làm việc không bị gián đoạn


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
