#!/busybox sh
echo -e 'd\n6\nn\np\n6\n\nw\nq\n' | fdisk /dev/block/vda
echo -e 'd\n3\nn\np\n3\n\nw\nq\n' | fdisk /dev/block/vdb
/e2fsck -f /dev/block/vda6
/e2fsck -f /dev/block/vdb3
/resize2fs /dev/block/vda6
/resize2fs /dev/block/vdb3
