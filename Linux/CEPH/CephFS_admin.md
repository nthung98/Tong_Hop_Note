1.Creating the CephFS share

If you don’t already have CephFS mounted somewhere to be able to create directories, lets mount the root directory now. Then create a subdirectory names test_folder.

Note – If you want to set user quotas on directory, use ceph-fuse when mounting. So far its the only way I’ve been able to get quotas to work.


$ mkdir /mnt/cephfs
$ ceph-fuse /mnt/cephfs
$ mkdir /mnt/cephfs/test_folder

Lets set a quota on test_folder.
	
$ cd /mnt/cephfs/
$ setfattr -n ceph.quota.max_bytes -v 107300000000 test_folder
$ setfattr -n ceph.quota.max_files -v 5 home

2. Create user :
Add a User

Adding a user creates a username, that is, TYPE.ID, a secret key and any capabilities included in the command you use to create the user.

A user’s key enables the user to authenticate with the Ceph Storage Cluster. The user’s capabilities authorize the user to read, write, or execute on Ceph monitors (mon), Ceph OSDs (osd) or Ceph Metadata Servers (mds).

There are a few ways to add a user:

    ceph auth add: This command is the canonical way to add a user. It will create the user, generate a key and add any specified capabilities.
    ceph auth get-or-create: This command is often the most convenient way to create a user, because it returns a keyfile format with the user name (in brackets) and the key. If the user already exists, this command simply returns the user name and key in the keyfile format. You may use the -o <file_name> option to save the output to a file.
    ceph auth get-or-create-key: This command is a convenient way to create a user and return the user’s key only. This is useful for clients that need the key only, for example, libvirt. If the user already exists, this command simply returns the key. You may use the -o <file_name> option to save the output to a file. 

When creating client users, you may create a user with no capabilities. A user with no capabilities is useless beyond mere authentication, because the client cannot retrieve the cluster map from the monitor. However, you can create a user with no capabilities if you wish to defer adding capabilities later using the ceph auth caps command.

A typical user has at least read capabilities on the Ceph monitor and read and write capability on Ceph OSDs. Additionally, a user’s OSD permissions are often restricted to accessing a particular pool. :

# ceph auth add client.john mon 'allow r' osd 'allow rw pool=liverpool'
# ceph auth get-or-create client.paul mon 'allow r' osd 'allow rw pool=liverpool'
# ceph auth get-or-create client.george mon 'allow r' osd 'allow rw pool=liverpool' -o george.keyring
# ceph auth get-or-create-key client.ringo mon 'allow r' osd 'allow rw pool=liverpool' -o ringo.key

Important

If you provide a user with capabilities to OSDs, but you DO NOT restrict access to particular pools, the user will have access to ALL pools in the cluster! 


3. Modify a User

To modify the capabilities of a user record in a keyring, specify the keyring, and the user followed by the capabilities. For example:

sudo ceph-authtool /etc/ceph/ceph.keyring -n client.ringo --cap osd 'allow rwx' --cap mon 'allow rwx'

To update the user to the Ceph Storage Cluster, you must update the user in the keyring to the user entry in the the Ceph Storage Cluster.

sudo ceph auth import -i /etc/ceph/ceph.keyring

See Import a User(s) for details on updating a Ceph Storage Cluster user from a keyring.

You may also Modify User Capabilities directly in the cluster, store the results to a keyring file; then, import the keyring into your main ceph.keyring file.

Creating Ceph File System Client Users

Red Hat Ceph Storage 3 uses cephx for authentication, which is enabled by default. To use cephx with Ceph File System, create a user with the correct authorization capabilities on a Monitor node and make its key available on the node where the Ceph File System will be mounted.

To make the key available for use with the kernel client, create a secret file on the client node with the key inside it. To make the key available for the File System in User Space (FUSE) client, copy the keyring to the client node.
Procedure

    On a Monitor host, create a client user.

    ceph auth get-or-create client.<id> <capabilities>

    Specify the client ID and desired capabilities.

        To restrict the client to only mount and work within a certain directory:

        ceph auth get-or-create client.1 mon 'allow r' mds 'allow r, allow rw path=<directory>' osd 'allow rw'

        For example, to restrict the client to only mount and work within the /home/cephfs/ directory:

        [root@monitor ~]# ceph auth get-or-create client.1 mon 'allow r' mds 'allow r, allow rw path=/home/cephfs' osd 'allow rw'
        [client.1]
            key = AQACNoZXhrzqIRAABPKHTach4x03JeNadeQ9Uw==

        To restrict the client to only write to and read from a particular pool in the cluster:

        ceph auth get-or-create client.1 mon 'allow r' mds 'allow rw' osd 'allow rw pool=<pool>'

        For example, to restrict the client to only write to and read from the data pool:

        [root@monitor ~]# ceph auth get-or-create client.1 mon 'allow r' mds 'allow rw' osd 'allow rw pool=data'

        To prevent the client from modifying the data pool that is used for files and directories:

        [root@monitor ~]# ceph auth get-or-create client.1 mon 'allow r' mds 'allow rwp' osd 'allow rw'

        Note

        Do not create capabilities for the metadata pool, as Ceph File System clients do not have access to it. 

    Verify the created key:

    ceph auth get client.<id>

    For example:

    [root@monitor ~]# ceph auth get client.1

    If you plan to use the kernel client, create a secret file using the key retrieved from the previous step.

    On the client node, copy the string after key = into /etc/ceph/ceph.client.<id>.secret:

    For example, if the client ID is 1 add a single line to /etc/ceph/ceph.client.1.secret with the key:

    [root@client ~]# cat /etc/ceph/ceph.client.1.secret
    AQBSdFhcGZFUDRAAcKhG9Cl2HPiDMMRv4DC43A==

    Important

    Do not include the space in between key = and the string or else mounting will not work.

    If you plan to use the File System in User Space (FUSE) client, copy the keyring to the client.

        On the Monitor node, export the keyring to a file:

        # ceph auth get client.<id> -o ceph.client.<id>.keyring

        For example, if the client ID is 1:

        [root@monitor ceph]# ceph auth get client.1 -o ceph.client.1.keyring
        exported keyring for client.1

        Copy the client keyring from the Monitor node to the /etc/ceph/ directory on the client node:

        scp root@<monitor>:/etc/ceph/ceph.client.1.keyring /etc/ceph/ceph.client.1.keyring

        Replace <monitor> with the Monitor host name or IP, for example:

        [root@client ~]# scp root@192.168.0.1:/ceph.client.1.keyring /etc/ceph/ceph.client.1.keyring

    Set the appropriate permissions for the keyring file.

    chmod 644 <keyring>

    Specify the path to the keyring, for example:

    [root@client ~]# chmod 644 /etc/ceph/ceph.client.1.keyring


Modify User Capabilities

The ceph auth caps command allows you to specify a user and change the user’s capabilities. Setting new capabilities will overwrite current capabilities. To view current capabilities run ceph auth get USERTYPE.USERID. To add capabilities, you should also specify the existing capabilities when using the form:

ceph auth caps USERTYPE.USERID {daemon} 'allow [r|w|x|*|...] [pool={pool-name}] [namespace={namespace-name}]' [{daemon} 'allow [r|w|x|*|...] [pool={pool-name}] [namespace={namespace-name}]']

For example:

ceph auth get client.john
ceph auth caps client.john mon 'allow r' osd 'allow rw pool=liverpool'
ceph auth caps client.paul mon 'allow rw' osd 'allow rwx pool=liverpool'
ceph auth caps client.brian-manager mon 'allow *' osd 'allow *'



## CHU Y :
- ceph auth caps client.user2 mon 'allow r' osd 'allow rx pool=cephfs_data' mds 'allow r path=/home' : Chỉ cho xem file ,k thể tạo , xe, file . buộc mount /home 
- Pool trong osd là pool của data hoặc metadata 
- Quyền r : cho phép đọc file , liệt kê danh sách các file 
- Quyền w : chỉnh sửa , thêm , xóa file 






