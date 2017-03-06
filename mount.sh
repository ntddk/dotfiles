#!/bin/bash
IMAGE_FILE=$1
modprobe nbd
qemu-nbd -c /dev/nbd0 ${HOME}/${IMAGE_FILE}
/sbin/fdisk -l /dev/nbd0
#mount -o loop,offset=$((63*512)) /dev/nbd0 /mnt/
mount -o loop,offset=$((206848*512)) /dev/nbd0 /mnt/

