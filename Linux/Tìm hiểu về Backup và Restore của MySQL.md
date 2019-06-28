# BACKUP và RESTORE MYSQL  
1. Sao Lưu Cơ Sở Dữ Liệu

Việc sao lưu (hay còn gọi là export hoặc backup) được sử dụng nhờ câu lênh mysqldump, câu lệnh này sẽ chuyển toàn bộ dữ liệu có trong database ra một file. Cú pháp câu lệnh này như sau:

mysqldump -u [username] -p [database] > [filename].sql

Trong đó:

    username: Là tên người dùng có quyền sao lưu cơ sở dữ liệu
    database: Là tên cơ sở dữ liệu cần backup
    filename: Là tên file dùng để lưu dữ liệu được sao lưu
    
2. Restore

Sử dụng lệnh sau

mysql -u [uname] -p [dbname] < [backupfile.sql]

Trong đó:

[uname] : user của database

[dbname] : Tên của database

[backupfile.sql] : Tên file backup đã lưu (file backup muốn phục hồi)
