# CÁC LỆNH CƠ BẢN  
**echo**  
- Cú pháp :   
`echo [option(s)] [string(s)]`  

- Các tùy chọn :  
   - Lưu ý : cần có -e sau lệnh echo để có thể sử dụng các backslash escapes như \n \b  

**\b** : Xóa bỏ khoảng cách giữa các chữ  
**\t** : Tạo tab space 
**\n** : Xuống dòng  

echo * : Hiển thị các file,folder .   
echo "abc" > file : chèn dòng chữ vào file , xóa hết các dữ liệu cũ.    
echo >> : chèn thêm dòng chữ xuống dưới , dữ liệu cũ giữ nguyên .  

**chmod**  
`chmod option owner(+,-)(r,w,x) file/folder`  
Với owner gồm : u = user, u = group, o = others  

**Hiển thị RAM , CPU**  
Hiển thị CPU :  
`cat /proc/cpuinfo`    
`nproc`  :Số nhân xử lí của cpu  
`lsccpu`  
Hiển thị RAM :  
`cat /proc/meminfo`   
`free`  

**Hiển thị các gói đã cài đặt**  
`rpm -qa`   
 `yum list installed`  

 **Hiển thị các file nén trong hệ thống**  
 find . -iname \*.zip   

 ### **Biến môi trường trong linux**  
- Khi làm việc trên máy tính chúng ta cần những thông tin như tên phiên bản hệ điều hành (HĐH) đang chạy, tên thư mục home, thư mục chứa lệnh chương trình …

- Một khái niệm quan trọng trên linux đó là môi trường (environment) được định nghĩa qua các biến môi trường. Một số biến được đặt bởi hệ thống, số khác do bạn đặt, hoặc set bởi shell (các lệnh) hay một chương trình nào đó được load.

- Một biến môi trường có tên là một dãy chữ cái và nhận một  giá trị nhất định, giá trị này có thể là số, chữ, tên file, thiết bị (device) hay một kiểu dữ liệu nào đó.  

- Các biến môi trường lưu trong mục home của người dùng: .bashrc, .bash_profile, .bash_aliasses, /etc/profile


### Các biến môi trường căn bản :  
 - Biến $HOME :  
 HOME là một biến môi trường đại diện cho thư mục home của người dùng. Lệnh cd không có đối số sẽ thay đổi thư mục làm việc hiện tại thành giá trị của HOME. Nghĩa là lệnh cd $HOME và cd ~ là tương đương nhau .  
 
 - Biến $PATH :  
PATH là biến đưa ra danh sách các directory mà hệ thống tìm đến khi thực hiện các lệnh hoặc script để chạy . Mỗi directory path được ngăn cách bởi dấu ":" .



   