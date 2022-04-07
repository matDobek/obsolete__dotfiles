#!/usr/bin/env bash

#
# fdisk -l
# lsblk
#
#NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
#nvme0n1     259:0    0 953.9G  0 disk
#├─nvme0n1p1 259:1    0   512M  0 part
#├─nvme0n1p2 259:2    0   512G  0 part
#└─nvme0n1p3 259:3    0 441.4G  0 part

partition_boot=/dev/nvme0n1p1
partition_prim=/dev/nvme0n1p2
partition_secd=/dev/nvme0n1p3

echo "===================="
echo "Create filesystem"
echo "===================="

mkfs.fat -F32 $partition_boot
mkfs.ext4 -F $partition_prim
mkfs.ext4 -F $partition_secd

echo "===================="
echo "Mount Linux and install base dependencies"
echo "===================="

mount $partition_prim /mnt
pacstrap /mnt base linux linux-firmware vim neovim networkmanager sudo

echo "===================="
echo "Setup file system table (all available disks and partitions)"
echo "===================="

genfstab -U /mnt >> /mnt/etc/fstab

echo "===================="
echo "Setup custom scripts"
echo "===================="

mkdir -p /mnt/home/cr0xd
#cp /root/bootstrap1.sh /mnt/home/cr0xd/
#cp /root/bootstrap2.sh /mnt/home/cr0xd/
cp -r /media/usb/main* /mnt/home/cr0xd/

echo "===================="
echo "Log in to the new system"
echo "===================="

arch-chroot /mnt
