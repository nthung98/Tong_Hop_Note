# GHI CHÚ  
## 1. Kiến trúc :  
 Glusterfs đem lại tính ổn định cũng như linh hoạt trong việc nâng cấp hệ thống .  
 Khi mở rộng hệ thống theo chiều rộng , khó khăn nhất là giữ track giữa các logical và physical location của dữ liệu và metadata . Đa phần các hệ thống phân tán sẽ tạo một metada server để theo dõi vị trí , với hệ thống truyền thống sẽ sinh thêm rất nhiều file , nhiều server , ổ đĩa , khiến metadata server bị quá tải .  
 Khác với các kiểu lưu trữ truyền thống , gluster không sử dụng metadata server , và theo dõi vị trí file bằng thuật toán dùng hàm băm . 

## 2. Các khái niệm :  
## Brick
## Volume  
## Subvolume :  
Một brick sau khi được một translator nắm quyền 
## Translator :  
KẾt nối đến một hoặc nhiều subvolumes . Có thể thực hiện các tác vụ trên chúng và cung cấp kết nối subvolume (subvolume connection)  
## Volfile :  
Volume (vol ) files  được cấu hình để định nghĩa các hành động của gluster trusted storage pool. Ở các level cao hơn ,  GlusterFS có 3 thực thể là Server Client và Management daemon . Mỗi một thực thể này có volfile riêng . Volume files cho server và clients được tạo bởi management daemon  
File thường được lưu trữ tại `/var/lib/glusterd/vols/VOLNAME` . Còn file của management daemon thì được lưu tại `/etc/glusterfs/glusterd.vol`  

## glusterd  
Là service glusterFS Management cần chạy trên server  có chứa trusted storage pool.
## Cluster  
Tương tự trusted storage pool

## Trusted storage pool  
Trong một hệ thống GlusterFS, những server dùng để lưu trữ được gọi là những node, và những node này kết hợp lại với nhau thành một không gian lưu trữ lớn được gọi là Pool. Dưới đây là 
## Client 
Máy tính mount dường dẫn của volume để sử dụng (Server cũng có thể mount đường dẫn đó để sử dụng )
  
  ## File System :  
  Phương thức để lưu trữ và tổ chức hệ thống file máy tính .  
  ## Distributed File System :  
  FIle system cho phép nhiều client truy cập dữ liệu và được lưu trữ  trên khác các servers /bricks thuộc cùng một trusted storage pool.
  ## Virtual File System (VFS)  
  Là kernel software layer xử lý các system calls liên quan đến file system của linux . Cung cấp interface cho file system.  
  ## POSIX :  
  ## Metadata :  
  Dữ liệu cung cấp thông tin về các mảnh dữ liệu khác .  
  ## FUSE :  
  Filesystem in User space là một loadable kernel module cho các hệ điều hành Unix-like cung cấp quyền cho người dùng tạo file của họ mà không cần chỉnh sửa code kernel.
  
  ## Petabyte :  
  1PB = 10^15B = 1000TB  

## 3. Các lệnh thường dùng :  
- Add 1 node vào pool:
```
gluster peer probe <server>
```

- Xem status của pool:
```
gluster peer status
```  

- Xóa node ra khỏi pool:

```
gluster peer detach <server>
```

- Tạo volume:
```
gluster volume create <volume-name> [stripe COUNT | replica COUNT] [transport [tcp |rdma] ] <brick1> <brick2>.... <brick n>
```
- Start volume:

```
gluster volume start <volume-name>
```

- Xem thông tin volume đã tạo:
```
gluster volume info
```
- Stop volume:
```
gluster volume stop <volume-name>
```
- Xóa volume:
```
gluster volume delete <volume-name>
```
- Add thêm brick vào volume:
```
gluster volume add-brick <volume-name> <server:/data>
```
>Trong đó <server:/data> là đường dẫn của brick cần add, ví dụ 192.168.0.1:/mnt/brick1

- Tương tự Remove brick ra khỏi volume:
```
gluster volume remove-brick <volume-name> <server:/data>
```  