sudo systemctl start ceph-osd.target
sudo systemctl start ceph-mon.target
sudo systemctl start ceph-mds.target

> Lưu ý : Chạy lên trên ở các node .

Starting a Daemon

To start a specific daemon instance on a Ceph Node, execute one of the following:

sudo systemctl start ceph-osd@{id}
sudo systemctl start ceph-mon@{hostname}
sudo systemctl start ceph-mds@{hostname}

