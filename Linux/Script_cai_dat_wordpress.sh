#!/bin/bash -e  
# Script cai lamb và wordpress  
echo -n "Dat ten MySQL DB : "
read mysqldb

echo -n "Dat MySQL DB User: "
read mysqluser

echo -n "Dat mat khau MySQL Password: "
read mysqlpass  
# Cai dat httpd
echo -n "Cai dat httpd"
 yum install -y httpd  
 systemctl start httpd.service  
systemctl enable httpd.service  
 mkdir /etc/httpd/sites-available  
 mkdir /etc/httpd/sites-enabled  
echo "
IncludeOptional sites-enabled/*.conf ">>/etc/httpd/conf/httpd.conf 
#Cai dat mysql  
echo -n "Cai dat mariadb"
 yum install  -y mariadb-server mariadb  
 systemctl start mariadb  
#mysql_secure_installation

#Cai dat php 
 yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
 yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
 yum install -y yum-utils
yum-config-manager --enable remi-php56

yum install -y  php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfoce
systemctl restart httpd.service
#Cau hinh wordpress


#echo -n "Enter your MySQL root password: "
#read -s rootpass
mysql -u root -p <<ten_script
CREATE DATABASE $mysqldb ;
CREATE USER $mysqluser@localhost IDENTIFIED BY '$mysqlpass';
GRANT ALL PRIVILEGES ON $mysqldb.* TO $mysqluser@localhost   IDENTIFIED BY '$mysqlpass';
FLUSH PRIVILEGES;
   exit
ten_script
#Cai dat wordpress  
service httpd restart  
cd ~
sudo wget http://wordpress.org/latest.tar.gz  
tar xzvf latest.tar.gz  
cd wordpress/
cp wp-config-sample.php wp-config.php  

 
sed -e "s/database_name_here/"$mysqldb"/" -e "s/username_here/"$mysqluser"/" -e "s/password_here/"$mysqlpass"/" wp-config-sample.php > wp-config.php 
sudo mkdir -p /var/www/relayserver.com/public_html    
sudo mv ~/wordpress/* /var/www/relayserver.com/public_html/  
  
sudo chown -R apache:apache /var/www/relayserver.com/public_html/      
touch /etc/httpd/conf.d/relayserver.com.conf   

echo "
<VirtualHost *:80>  

ServerAdmin www.relayserver.com  
ServerName relayserver.com  
ServerAlias www.relayserver.com  
DocumentRoot /var/www/relayserver.com/public_html/  
</VirtualHost>

" >> /etc/httpd/conf.d/relayserver.com.conf   

ln -s /etc/httpd/conf.d/relayserver.com.conf /etc/httpd/sites-enabled/relayserver.com.conf     

sudo apachectl restart     