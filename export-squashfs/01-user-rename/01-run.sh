#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" rename-user -f -s
	#Assume if they're doing squashfs that we can skip user creation
	systemctl disable userconfig
	systemctl mask userconfig
EOF
