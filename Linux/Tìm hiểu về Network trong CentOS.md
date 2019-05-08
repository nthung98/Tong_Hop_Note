# CÁC INTERFACES CỦA CENTOS :   

- en: cáp ethernet nối trực tiếp   
 wl: Kết nối wifi  
 lo: Địa chỉ loopback  
- Thường các interface được đặt theo qui tắc sau :   
	1. Tên đặt theo  số được Firmware/BIOS cung cấp ở cổng onboard (VD: eno1)  
	2. Tên đặt theo số được  Firmware/BIOS cung cấp ở cổng  PCI Express hotplug  (BF: ens1)  
	3. Tên đặt theo địa chỉ cổng vật lí của phần cứng (BF: enp2s0)
	4. Tên theo MAC (BF: enx78e7d1ea46da)  
	5. Tên theo kiểu cũ , thường dùng nếu tất cả các qui tắc trên không dùng được (VD: eth0)  


# CHUYỂN ĐỔI TÊN CỦA INTERFACE:  

- Chỉnh file trong đường dẫn sau  /etc/default/grub file bằng việc thêm *net.ifnames=0* *biosdevname=0* ở cuối dòng  GRUB_CMDLINE_LINUX .  

	- Thử cấu hình bằng lệnh grub ở dưới :  
      `grub2-mkconfig`  
    
    - Nếu không có lỗi chúng ta áp dụng các chỉnh sửa bằng lệnh :  
     ` grub2-mkconfig -o /boot/grub2/grub.cfg  `

   - Sau đó đổi tên file ở cd /etc/sysconfig/network-scripts:  
 ` mv ifcfg-ens33 ifcfg-eth0  `
	- Mở file  **ifcfg-eth0** và chuyển tên của DEVICE và NAME thành eth0:  

	- Reboot hoặc restart lại network và kiểm tra tên interface:  
      `  service network restart`



	

# THAY ĐỔI IP TĨNH :

* Vào thư mục có đường dẫn sau : /etc/sysconfig/network-scripts/

