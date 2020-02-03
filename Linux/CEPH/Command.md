1.OSD DOwn
sudo systemctl restart ceph-osd.target
sudo systemctl restart ceph-mon.target
sudo systemctl restart ceph-mds.target

sudo systemctl restart ceph.target


> Lưu ý : Chạy lên trên ở các node .

Starting a Daemon

To start a specific daemon instance on a Ceph Node, execute one of the following:

sudo systemctl start ceph-osd@{id}
sudo systemctl start ceph-mon@{hostname}
sudo systemctl start ceph-mds@{hostname}

2. Cai dat : 
khi loi can overwrite config ( config o cac file trung nhau)
ceph-deploy --overwrite-conf  admin node01 node02 node03 node04

3. Xóa image :  

Phải xóa  trực tiếp pool 
 ceph osd pool delete rbdpool rbdpool --yes-i-really-really-mean-it

4. Tạo user cho cephfs :
- ceph auth get-or-create client.1 mon 'allow r' mds 'allow r, allow rw path=/home' osd 'allow rw'
    ceph auth get client.1
  ceph auth get client.1 -o /etc/ceph/ceph.client.1.keyring

- Copy key sang client scp /etc/ceph/ceph.client.1.keyring root@client1:/etc/ceph



systemctl restart chronyd.service

ceph mgr module disable dashboard

ceph config set mgr mgr/dashboard/$name/server_addr $IP

ceph auth ls

ceph fs ls

ceph mds stat
