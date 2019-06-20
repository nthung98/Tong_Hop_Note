# INSTALL WORDPRESS VÀ SQL SERVER TRÊN 2 NODE 
## Mô hình :  
<img src="https://i.imgur.com/WjLXPDZ.png">   

### Tại SQL Server:  

 - Lệnh cài đặt :  

```
yum install mariadb-server
```
- Khởi chạy mariadb :  
```
systemctl start mariadb
```
- Kiểm tra mariadb đã chạy :  
```
systemctl status mariadb
```
- Để mariadb chạy khi system khởi động dùng lệnh sau :  
```
systemctl enable mariadb
```
- Sau khi cài xong cần có những cài đặt bảo mật :
```
mysql_secure_installation
```

- Cấu hình Mariadb cho phép web server truy cập :  
sửa file /etc/my.conf  


-Tạo user và database cho webserver :
Tạo database :  
```
CREATE DATABASE wordpress;
```

Ta tạo một mysql user mới chỉ được quyền truy cập vào wordpress database .   
```
CREATE USER user@Ip_WebServer IDENTIFIED BY 'password';
```
Phân quyền cho user đó :  
```

GRANT ALL PRIVILEGES ON wordpress.* TO user@Ip_WebServer IDENTIFIED BY 'password';
```
```
Lưu ý : Ip_WebServer ở đây là ip của webserver , trong trường hợp này là 4.4.4.4
```

### Tại Web Server   

 - Giải nén bằng lệnh tar :  
```
tar xzvf latest.tar.gz
```  
- Sau đó copy file cấu hình mẫu ra một file cấu hình riêng :   
```
cp wp-config-sample.php wp-config.php
```

- Tạo directory của apache chứa web wordpress : 
```
mkdir -p /var/www/web2node.com/public_html
  ```  

  - Chuyển file wordpress về thư mục 
 ```    
mv ~/wordpress/* /var/www/web2node.com/public_html/
  
chown -R apache:apache /var/www/web2node.com/public_html/  
```  
- Cấu hình file  cho website ở đường dẫn /etc/httpd/conf.d/ 
```
vi /etc/httpd/conf.d/web2node.com.conf
```  
```
<VirtualHost *:80>

ServerAdmin www.web2node.com
ServerName web2node.com
ServerAlias www.web2node.com
DocumentRoot /var/www/web2node.com/public_html/
</VirtualHost>


```
- Copy file vừa cấu hình sang sites-enabled :
```
ln -s /etc/httpd/conf.d/web2node.com.conf /etc/httpd/sites-enabled/web2node.com.conf
```
Sau đó ta restart lại service để áp dụng các thay đổi :  
```
sudo apachectl restart  
```
- Cấu hình file của wordpress :   

```
vi /var/www/web2node.com/public_html/wp-config.php  
```   

```
/** The name of the database for WordPress */
define('DB_NAME', 'database');

/** MySQL database username */
define('DB_USER', 'username');

/** MySQL database password */
define('DB_PASSWORD', 'password');

/** MySQL hostname */
define('DB_HOST', 'database_server_ip'); 
```
```
Lưu ý :
- database: database ta tạo ra tại SQL server
- username: Username SQL server cấp phát 
- database_server_ip: IP của SQL server ,trong trường hợp này là 4.4.4.4
```  

Sau khi cấu hình xong tại 2 node , ta truy cập vào bằng domain web đã cài đặt , nếu hiện lên màn hình sau là thành công :  
<img src="https://i.imgur.com/KXvvPV5.png">