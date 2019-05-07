 # Cấu hình RIP :  
 <img src="https://i.imgur.com/mhSrP79.png">  
 Các router chạy RIP version 2 , từ các PC và các Router có thể ping đến các mạng khác .


- Cấu hình Router 0 :  
```
  #int f0/0
  #ip add 192.168.0.1 255.255.255.0
  #int f0/1 
  #ip add 10.0.0.1 255.255.255.252 
  #int f1/0
  #ip add 11.0.0.1 255.255.255.252
  #int eth0/3/0
  #ip add 14.0.0.1 255.255.255.252 
  #router rip
  #ver 2
  #network 192.168.0.0
  #network 10.0.0.0
  #network 11.0.0.0
  #network 14.0.0.0


``` 

- Cấu hình Router 1 :  



