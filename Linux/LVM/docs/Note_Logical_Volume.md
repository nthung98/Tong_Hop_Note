# NOTE VỀ CÁC LOGICAL VOLUME 

## Logical volume striped 
- Có 4 partition để tạo volume group , nếu chỉ tạo logical volume với option striped là 2 thì dữ liệu sẽ ghi vào mấy ổ .
### Lab :  
- Ta thấy tạo 4 physical volume cho volume group striped là sdb1 , sdb2,sdc1,sdc2

<img src="../img/Note_logical_volume_1.1.png",width=800>

- Tạo logical volume : 
 ```
 lvcreate -L 60M -n lv_striped -i2 vg_striped
 ```  

<img src="../img/Note_logical_volume_1.4.png">

- Sau khi tạo logical volume  ta kiểm tra physical volume bằng lệnh :
```
pvdisplay -v
```  
- Ta thấy 2 physical volume sdb1 và sdb2 được sử dụng để lưu trữ .

<img src="../img/Note_logical_volume_1.2.png">

- Trong đó 2 ổ sdc1 và sdc2 chưa được sử dụng

<img src="../img/Note_logical_volume_1.3.png">
