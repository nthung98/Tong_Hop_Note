# 1.BASIC COMMANDS :  

**Locating Applications**  
Tùy vào từng bản phân phối , các phần mềm và chương trình có thể được cài đặt ở các directory khác nhau . Nhưng các lệnh, chương trình thực thì thường được lưu ở các directory sau : 
```
/bin
/usr/bin
/sbin
/usr/sbin
/opt
```  
Có thể dùng **which** để tìm được vị trí được lưu của phần mềm .  
Ví dụ : 
$ which diff  
/usr/bin/diff
  
  Nếu which không dùng được có thể dùng whereis thay thế 
$ whereis diff  
diff: /usr/bin/diff /usr/share/man/man1/diff.1.gz  

**Accessing Directories**
  
|Command|Kết quả|
|---|---|
|cd|Chuyển về home|
|cd..|Chuyển về thư mục cha|
|cd-|Chuyển về thư mục trước |
|cd/|Chuyển về thư mục root|

**Exploring the Filesystem**
|Command|Kết quả|
|--|--|
|ls|Liệt kê các file và thư mục trong directory|
|ls -a | Liệt kê tất cả các file bao gồm các file và directory hidden|
|tree| Hiển thị tree view |
|tree -d | Danh sách directory và file|

**Hard and Symbolic Links**
