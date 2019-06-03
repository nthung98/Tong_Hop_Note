# NFS  

    NFS – Network File System là dịch vụ chia sẻ file trong môi trường network giữa các server Linux.
    Dịch vụ NFS cho phép các NFS client mount một phân vùng của NFS server như phân vùng cục bộ của nó.
    Dịch vụ NFS không được security nhiều, vì vậy cần thiết phải tin tưởng các client được permit mount các phân vùng của NFS server.
Hiện tại có 3 phiên bản NFS là NFSv2, NFSv3, NFSv4.  
different processes on the server that enable's the working of NFS.

rpc.mountd: This is the process on the server that waits for mount requests from the clients. This process confirms the exports on the server. starting the nfs service on the server also start's this service.

rpc.statd : This process keeps the nfs clients informed about the current status of the nfs server. This process also gets started if you start the nfslock service from the init script.

rpc.quotad: This process implements the same quota related details on the local system for remote user's.  

rpc.idmapd : maps nfsv4 names and local UIDs and GIDs  

## Cấu hình NFS server và client  
<img src="https://i.imgur.com/GtQq8OC.jpg">  


