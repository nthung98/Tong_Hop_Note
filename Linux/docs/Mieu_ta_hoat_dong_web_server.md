Mô tả :  
Trong bài viết sử dụng 2 máy ảo Centos 7 , 1 máy chạy apache web server , 1 máy còn lại làm client  

<img src="https://i.imgur.com/es6n5A4.png">  

Khi ở client , ta bật browser lên và nhập tên web ta muốn truy cập :  
<img src="https://i.imgur.com/8Gc6oNU.png">   
Tùy vào thuật toán tìm kiếm hoặc lịch sử của browser , nó sẽ gợi ý  web mình cần hoặc các web với tên tương tự .  

Sau khi nhấn enter , browser sẽ chạy dns lookup :  
- Browser check tại cache đầu tiên (cache của firefox , chrome ....)   
- Nếu không tìm thấy , máy client sẽ chạy các dns lookup đến các địa chỉ dns server để tìm địa chỉ website cần truy cập.(ARP request ) 
- Client sẽ gửi bản tin broadcast arp request ,khi dns server xác nhận được địa chỉ sẽ gửi lại thông tin cho client để client có thể kết nối tới website bằng bản tin arp reply .  
<img src="https://i.imgur.com/EnyeBZY.png"> 

- Tại trường hợp này ta truy cập vào website wordpress chạy trên virtual host của server , nên ta cần cấu hình dns tại file hosts của client :  
<img src="https://i.imgur.com/gOUDkvP.png">  

Sau khi nhận đủ địa chỉ IP và thông tin cần thiết , browser thiết lập kết nối TCP đến web server để lấy dữ liệu (TCP-threeway handshake)  
<img src="https://i.imgur.com/pyZWXxW.png">  
TCP-threeway handshake thiết lập kết nối giữa hai máy với nhau .Với ví dụ ở đây client sẽ gửi bản tin SYN để xác nhận là muốn thiết lập kết nối với server.Server sau khi nhận SYN sẽ gửi lại với bản tin SYN-ACK .Sau khi nhận được bản tin của server  client sẽ gửi lại bản tin ACK để để xác nhận . Sau đó kết nối giữa 2 máy được thiết lập  
<img src="https://i.imgur.com/rfqD4am.png">  
Ta có thể thấy sau khi bắt gói tin , client với IP 192.168.30.137 đã gửi bản tin SYN để thiết lập kết nối , Server với IP 192.168.30.55 đã gửi lại với SYN_ACK và cuối cùng client gửi lại bản tin ACK Để thiết lập kết nối .  

Khi thiết lập kết nối thành công , client sẽ gửi HTTP request GET để nhận dữ liệu và giữ kết nối tcp .  
Web server sẽ xử lý các request của client .Sau khi xử lý xong server sẽ gửi lại HTTP response cho client bao gồm các content , các file cần thiết rồi gửi lại cho client.  
<img src="https://i.imgur.com/9m93VAw.png">  
Như ảnh trên, sau khi xong quá trình bắt tay 3 bước tạo kết nối tcp , client gửi http request GET để lấy dữ liệu  ,client gửi lại bản tin HTTP response.  
Browser tại client sẽ hiển thị website với các file html , css , php ,javascript ...  
<img src="https://i.imgur.com/sTT4TXs.png">  