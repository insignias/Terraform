#!/bin/sh

sudo mkdir /data
sudo echo "/dev/xvdb /data ext4 defaults 0 0" >> /etc/fstab
sudo mkfs.ext4 /dev/xvdb
sudo mount /data
