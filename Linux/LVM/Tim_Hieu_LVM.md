# TÌM HIỂU VỀ LVM  
## 1. Định nghĩa :  
Logical Volume Manager (LVM) là phương pháp quản lý các storage device, các logical volume dễ dàng ,linh hoạt hơn .Với kỹ thuật Logical Volume Manager (LVM) bạn có thể thay đổi kích thước mà không cần phải sửa lại partition table của OS .  


## 2. Cấu trúc LVM :  
<img src="https://i.imgur.com/AdBMktq.png">    
LVM phân các lớp trên các ổ cứng vật lý .Bao gồm các thành phần sau :      
- Hard drives – Drives

Thiết bị lưu trữ dữ liệu, ví dụ như trong linux nó là /dev/sda

- Partition

Partitions là các phân vùng của Hard drives, mỗi Hard drives có 4 partition, trong đó partition bao gồm 2 loại là primary partition và extended partition

   -  Primary partition:

    Phân vùng chính, có thể khởi động
    Mỗi đĩa cứng có thể có tối đa 4 phân vùng này

    - Extended partition:

    Phân vùng mở rộng

- Physical Volumes:    
   - Kí hiệu : pv...  
   - Là những thành phần cơ bản được sử dụng bởi LVM dể xây dựng lên các tầng cao hơn . Một Physical Volume không thể mở rộng ra ngoài phạm vi một ổ đĩa. Chúng ta có thể kết hợp nhiều Physical Volume thành Volume Groups   
   - Volume Group

Nhiều Physical Volume trên những ổ đĩa khác nhau được kết hợp lại thành một Volume Group

Volume Group được sử dụng để tạo ra các Logical Volume, trong đó người dùng có thể tạo, thay đổi kích thước, lưu trữ, gỡ bỏ và sử dụng.

Một điểm cần lưu ý là boot loader không thể đọc /boot khi nó nằm trên Logical Volume Group. Do đó không thể sử dụng kỹ thuật LVM với /boot mount point 
- Logical Volumes:  
 - Kí hiệu: lv...(có thể là lvm... trong hệ thống)  
 - Có chức năng là các phân vùng trong ổ cứng vật lý , nhưng có thể linh hoạt hơn.Là thành phần chính để người dùng và các phần mềm tương tác .  
