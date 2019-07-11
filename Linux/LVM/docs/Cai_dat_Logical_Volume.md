# LOGICAL VOLUME  

## 1. Cài đặt Linear :  
Linear là mặc định của các logical volume khi được tạo . Xem bài viết sau  
/Linux/LVM/docs/Tim_Hieu_LVM.md

## 2. Cài đặt Striped:  
Từ Volume group được tạo trước , ta dùng lệnh sau :  
```
lvcreate -L 500M -i2 -n lv-strip vg1
```  
Chú ý:  
 -L dung lượng tạo logical volume , ở đây là 500MB  
 -i2 số physical volume ta ghi vào khi sử dụng striped,  ở đây khi dữ liệu được ghi vào sẽ chia vào 2 physical volume  

<img src="https://i.imgur.com/2azZccY.png">
Ta có thể kiểm tra bằng các lệnh :  

```
pvdisplay -m

lvs --segments

```
<img src="https://i.imgur.com/TQNWvWK.png">   
Logical volume có type là striped .  


**Lưu ý:  
Khi chạy striped volume , các Physical volume tạo nên volume group mà logical volume sử dụng sẽ chia đôi dung lượng logical volume đã tạo ra và chia đều cho các PV .**  
  

<img src="https://i.imgur.com/RaI3ez0.png"> 

Ta thấy với 2 Physical Volume 1GB sdb2 và sdc2 , mỗi PV nhận khoảng 250MB (63PE ) để lưu trữ dữ liệu của logical volume 500MB.

## 3. Cài đặt Mirror:  
 Tương tự như striped , ta tạo logical volume từ volume group đã được tạo trước bằng lệnh :  
 ```
 lvcreate -L 500M -m1 -n mirrorlv vg1
 ```  
 Trong đó :  
 -L dung lượng Logical volume
 -m1 số mirror lưu ,ở đây ta tạo 2 mirror lưu vào 2 ổ 
 <img src="https://i.imgur.com/pibr7WC.png">  

 **Lưu ý :   
  Khi tạo mirror volume thì các physical volume tạo nên volume group sẽ dành ra dung lượng bằng logical volume tạo ra (mirror)**  

 <img src="https://i.imgur.com/YTCgYTP.png">  

 Ta thấy với dung lượng 1GB ở ổ sdb1 và dbc1 (255 PE), cùng chung volume group 1 , cả 2 physical volume trên dành ra một dung lượng là 500MB mỗi PV (126 PE) để lưu trữ cho logical volume mirror .  

 Kiểm tra bằng các lệnh tương tự như của striped:  
   <img src="https://i.imgur.com/anh1PEp.png">  
   Ta thấy type là Raid1 , tức là logical volume mirror đã được cài đặt thành công.

