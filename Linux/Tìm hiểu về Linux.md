# Chương 1.BASIC COMMANDS :  

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
`$ which diff ` 
/usr/bin/diff
  
  Nếu which không dùng được có thể dùng whereis thay thế   
`$ whereis diff`  
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
|ls -l | sẽ hiển thị tên file, directory cùng với size, ngày tháng chỉnh sửa gần nhất, user sở hữu và các permisson của user đó|  
|ls - r|Đưa ra danh sách với thứ tự ngược lại |  
|ls -R |Liệt kê thành các cây thư mục |  
|||  
|||  
|||
|tree| Hiển thị tree view |
|tree -d | Danh sách directory và file|

**Hard and Symbolic Links**  
Lệnh ln dùng để tạo hard link hoặc soft links (Symbolic and Hard link)  
Giả sử có file file1.txt . Ta tạo một hard link với file file2.txt như sau   
`#ln file1.txt file2.txt`

Dùng lệnh ls -l và -li để xem thông tin file , ta thấy file1 và file2 chỉ cùng đến 1 inode number
```
ls -l file*
-rw-rw-r--. 2 thanhhung98 thanhhung98 12 May  7 10:20 file1.txt
-rw-rw-r--. 2 thanhhung98 thanhhung98 12 May  7 10:20 file2.txt

```  

Tạo một soft links (Symbolic links) ta dùng lệnh sau  
`ln -s file1.txt file4.txt`

Xem thông tin file
 ``` 
 ls -l file*
-rw-rw-r--. 2 thanhhung98 thanhhung98 12 May  7 10:20 file1.txt
-rw-rw-r--. 2 thanhhung98 thanhhung98 12 May  7 10:20 file2.txt
lrwxrwxrwx. 1 thanhhung98 thanhhung98  9 May  7 10:18 file4.txt -> file1.txt
```

Ta thấy file 4 không phải là một file bình thường nó chỉ vào file1 và có inode number khác . Symbolic links k tốn dung lượng filesystem . Khi xóa file1 thì file4 không có tác dụng.


# Chương 2 : File streams

Thông thường khi lệnh được thực thi có 3 dangj file stream cos theer suwr dungj : 
1. Standard inout (stdin)
2. Standard output (stdout)
3. Standard error (stderr)

stdin là các luồng dữ liệu nhập từ bán phím , stdout và stderr được in ra trên terminal , thường in ra các file . Stderr thường được dẫn đến các error logging file .  

$ do_something < input-file
Để gửi thông tin của một lệnh vaof một file
$ do_something > output-file
Chuyển thông tin lỗi ra file
$ do_something 2> output_File

Có thể **pipe** nhiều lệnh vào ,Theo đó output của lệnh A sẽ là đầu vào cho lệnh B xử lý. Hai hay nhiều lệnh ghép lại với nhau theo cách này gọi là cơ chế ống dẫn (pipe
$ command1 | command2 | command3

Search for files 
