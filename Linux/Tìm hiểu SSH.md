# SSH
SSH (Secure Shell) là một giao thức mạng, giao thức này cho phép chúng ta kết nối đến một máy chủ Linux từ xa thông qua mạng Internet. Mọi dữ liệu gửi và nhận thông qua SSH đều được mã hóa giúp bảo mật thông tin an toàn hơn.


## CÀI ĐẶT VÀ SỬ DỤNG SSH  
### Cài đặt :   
 
 ` yum -y install openssh-server openssh-clients`  
###  SSH với username :   
   
`ssh localhost@IP_localhosst`  
<img src="https://i.imgur.com/4YTJBEP.png">  

### SSH với key :  
<img src="https://i.imgur.com/To19TMh.png">  

**- Cách thức hoạt động của SSH Key**

SSH Key bạn cứ hiểu đơn giản là một phương thức chứng thực người dùng truy cập bằng cách đối chiếu giữa một key cá nhân (Private Key) và key công khai(Public Key).  

Private key và Public key luôn có liên hệ chặt chẽ với nhau để nó có thể nhận diện lẫn nhau. Nội dung giữa Private Key và Public Key hoàn toàn khác nhau, nhưng nó vẫn sẽ nhận diện được với nhau thông qua một thuật toán riêng của nó. Khi thiết lập kết nối , máy chủ sẽ gửi public key cho các máy client muốn ssh từ xa , và máy chủ sẽ dùng private key để xác thực kết nối .    

**Thành phần chính của một SSH Key**

Khi tạo ra một SSH Key, bạn cần biết sẽ có 3 thành phần quan trọng như sau:

    Public Key (dạng file và string) – Bạn sẽ copy ký tự key này sẽ bỏ vào file ~/.ssh/authorized_keys trên server của bạn.
    Private Key (dạng file và string) – Bạn sẽ lưu file này vào máy tính, sau đó sẽ thiết lập cho PuTTY, WinSCP, MobaXterm,..để có thể login.
    Keypharse (dạng string, cần ghi nhớ) – Mật khẩu để mở private key, khi đăng nhập vào server nó sẽ hỏi cái này.  

**- Cấu hình**  
Từ một máy client ta muốn remote access vào một server .  
Tại client :   
`ssh-keygen -t rsa`
Gửi key public cho máy muốn remote :  
`ssh-copy-id localhost@IP_localhost`


Tại server :  
Chỉnh file /etc/ssh/sshd_config với các tùy chọn như sau :  
```sh
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

``` 

Nếu không muốn remote access bằng password và user , chỉ dùng key ta thêm tùy chọn  
```PassAuthentication no```  

Khi đó ta có thể truy cập từ Client SSH vào Server bằng key : 
<img src="https://i.imgur.com/k1rFk1w.png">