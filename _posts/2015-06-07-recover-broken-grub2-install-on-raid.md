---
layout: post
title:  "Recover broken Grub2 install on RAID"
date:   2015-05-05
categories: development
link: https://help.ubuntu.com/community/Grub2/Installing
---

After updating my mediacenter PC running [Linux Mint][mint] 16.1 Petra with XBMC to the newer 17.1 Rebecca version I 
rebooted into an unfortunate state:  

```sh
error: symbol 'grub_term_highlight_color' not found
Entering Rescue mode...
grub rescue>
```

This was apparently brought about due to a [bug in the grub2 package][grub2-bug] distributed with the Trusty Tahr 14
.04 LTS version of Ubuntu.  Since the Ubuntu package repositories back Linux Mint, when I updated from the now
unsupported Petra (backed by Ubuntu 13.10 Saucy Salamander), I inherited this gem.

As an added bonus, my installation is running on two separate RAID 10 arrays: one each for the OS and general storage
. What follows is the succinct directions on how to fix it for my own personal benefit in the event that it happens 
again.

0. [Boot into a Linux LiveUSB][live-usb]

As a friendly reminder to myself, in order to boot from a USB drive, I needed to update the hard drive order in the 
BIOS so that the "USB Mass Storage Drive" was the first hard drive.

0. Install mdadm in the LiveUSB instance: 

        sudo apt-get install mdadm


0. Assemble the mdadm RAID arrays:

        sudo mdadm --assemble --scan

0. Mount the array with the broken Grub2 installation:

        sudo mount /dev/md0 /mnt

0. Mount the critical directories within our RAID array mount:

        for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done

0. Jump into the RAID array mount:

        sudo chroot /mnt

0. Re-install Grub to all drives that make up the RAID array: 

        grub-install /dev/sdb
        grub-install /dev/sdc

0. Update the Grub config:

        update-grub

0. Restart the PC 

Moving forward I think I just need to remember to perform the last three steps following every update to either Grub 
or the kernel.

[mint]: http://www.linuxmint.com/
[grub2-bug]: https://bugs.launchpad.net/ubuntu/+source/grub2/+bug/1289977
[live-usb]: http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx