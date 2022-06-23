#!/bin/bash -e

#We want fstab to be mostly empty
echo proc            /proc           proc    defaults          0       0>${ROOTFS_DIR}/etc/fstab
