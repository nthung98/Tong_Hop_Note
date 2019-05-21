# DHCP RELAY 
DHCP Relay Agent là một cấu hình được đặt cho máy tính hoặc một Router tiếp nhận các thông tin yêu cầu cấp phát IP của clients và chuyển các thông tin này đến DHCP server  

Cơ chế hoạt động :  
 DHCP relay agent là thiết bị cấu tạo để  forward các DHCP requests đến DHCP server ở subnet khác . Các thao tác như sau :  

   -  Client gửi bản tin broadcast request đến DHCP server
  -   Di server ở subnet khác nên sẽ k có bản tin nào của server phản hồi lại , DHCP relay agent sẽ lấy bản tin của client và forward trực tiếp đến DHCP server ở subnet khác . 
    - DHCP Server trả lời trực tiếp client thông qua DHCP RElay agent

Ưu diểm của DHCP Relay

 – Cấp phát được IP cho các client ở lớp mạng khác .

 – Kết hợp với hệ thống mạng không dây ( Wireless) cung cấp tại các điểm – Hotspot như: nhà ga, sân bay, khách sạn, trường học.

 – Thuận tiện cho việc mở rộng hệ thống mạng.  

 Cài đặt :  
 
