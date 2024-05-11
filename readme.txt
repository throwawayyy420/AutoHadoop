** tat ca script chay trong root **

1/ Cai ubuntu server 22.04, update tat ca trong luc cai
2/ chay script 1 de update system
3/ chay script 2, 3 de cai hadoop, format namenode. sau khi script 3 xong thi vao user hadoop de format datanode, test(tu lam)
4/ chay script 4 de chinh yarn. Xong script 4 la xong single node
5/ chay script 5 de doi hostname, hosts, netplan cua master, chay script 6 de config master
6/ copy may master thanh slave, chinh ip cua slave (tu lam)
7/ chay script 7 tren slave de doi hostname lai thanh slave
8/ chay script 8 de config slave
9/ chay script 9 tren master de copy ssh key (dung user hadoop de chay script nay)
10/ backup/snapshot lai may neu ko loi
11/ format namenode
12/ vao user hadoop, chay test.sh theo file word cua co de test

>file mount-hgfs.sh dung de share file tu windows vao vmware.
>copy het script vao 1 thu muc, cap quyen execute de chay:

sudo -i
mkdir /mnt/hgfs/
/usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other   (hoac ./mount-hgfs.sh neu da co script)
cp /mnt/hgfs/shared <ten do user dat>/*.sh ~/scripts
chmod +x *
./<ten script>.sh