#!/sbin/busybox sh

ROM=$1

mkdir -p /.firstrom
mkdir -p /system

mount -t ext4 -o rw /dev/block/mmcblk0p37 /.firstrom

if [ "$ROM" == "secondary" ]; then
    losetup /dev/block/loop0 /.firstrom/media/.secondrom/system.img
    mount -t ext4 -o rw /.firstrom/media/.secondrom/system.img /system
elif [ "$ROM" == "tertiary" ]; then
    losetup /dev/block/loop0 /.firstrom/media/.thirdrom/system.img
    mount -t ext4 -o rw /.firstrom/media/.thirdrom/system.img /system
fi

umount -f /.firstrom
