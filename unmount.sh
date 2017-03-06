#!/bin/bash
umount /mnt
qemu-nbd -d /dev/nbd0
rmmod nbd

