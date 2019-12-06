1.OSD DOwn
sudo systemctl restart ceph-osd.target
sudo systemctl restart ceph-mon.target
sudo systemctl restart ceph-mds.target

> Lưu ý : Chạy lên trên ở các node .

Starting a Daemon

To start a specific daemon instance on a Ceph Node, execute one of the following:

sudo systemctl start ceph-osd@{id}
sudo systemctl start ceph-mon@{hostname}
sudo systemctl start ceph-mds@{hostname}

2. Xóa image :  

Phải xóa  trực tiếp pool 
 ceph osd pool delete rbdpool rbdpool --yes-i-really-really-mean-it
