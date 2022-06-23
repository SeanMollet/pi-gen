#!/bin/bash -e

on_chroot << EOF
    systemctl disable resize2fs_once
EOF
