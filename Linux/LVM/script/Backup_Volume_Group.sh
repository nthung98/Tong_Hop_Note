#!/bin/bash
echo -n "Nhap mat khau may backup "
read rootpass

NOW=`date '+%F_%H:%M:%S'`;  
yum --enablerepo=epel -y install sshpass

vgcfgbackup -f /home/thanhhung98/lv_backup_file/vg_backup_$NOW vg_backup
sshpass -p $rootpass scp -r /home/thanhhung98/lv_backup_file root@4.4.4.4:/home/relayserver/backup_lvm