---
layout: post
title:  "Create a bootable USB in OSX"
date:   2015-07-09
categories: development
link: http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx
---

I often find myself having to (re-)lookup the steps to create a bootable USB drive containing some variant of Linux 
to help me recover or update my system.  Below are those steps.

0. Convert the `.iso` file to `.img` using the convert option of `hdiutil`:

   ```sh
   ~ ❯❯❯ hdiutil convert -format UDRW -o output.img linuxmint-17.2-cinnamon-64bit.iso
   Reading Driver Descriptor Map (DDM : 0)…
   Reading Linux Mint 17.2 Cinnamon 64-bit  (Apple_ISO : 1)…
   Reading Apple (Apple_partition_map : 2)…
   Reading Linux Mint 17.2 Cinnamon 64-bit  (Apple_ISO : 3)…
   ..................................................................................
   Reading EFI (Apple_HFS : 4)…
   ..................................................................................
   Reading Linux Mint 17.2 Cinnamon 64-bit  (Apple_ISO : 5)…
   ..................................................................................
   Elapsed Time:  6.512s
   Speed: 238.9Mbytes/sec
   Savings: 0.0%
   created: output.img.dmg
   ```

   In this case, I'm converting a Linux Mint 17.2 Rafaela live CD `.iso`.
   
   Note: OSX puts the `.dmg` ending on the output file automatically.

0. Get the list of current USB devices:

   ```sh
   ~ ❯❯❯ diskutil list
   /dev/disk0
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:      GUID_partition_scheme                        *251.0 GB   disk0
      1:                        EFI EFI                     209.7 MB   disk0s1
      2:          Apple_CoreStorage                         250.1 GB   disk0s2
      3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   /dev/disk1
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:                  Apple_HFS Macintosh HD           *249.8 GB   disk1
                                    Logical Volume on disk0s2
                                    E3DC7498-72BB-4E26-9652-AAF99F84DC1F
                                    Unencrypted
   /dev/disk2
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:      GUID_partition_scheme                        *16.0 GB    disk2
      1:                        EFI EFI                     209.7 MB   disk2s1
      2:                  Apple_HFS Backups                 15.7 GB    disk2s2
   ```

0. Insert your USB drive.

0. Determine the device node assigned to your flash media by diff-ing the list of USB devices:

   ```sh
   ~ ❯❯❯ diskutil list
   /dev/disk0
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:      GUID_partition_scheme                        *251.0 GB   disk0
      1:                        EFI EFI                     209.7 MB   disk0s1
      2:          Apple_CoreStorage                         250.1 GB   disk0s2
      3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   /dev/disk1
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:                  Apple_HFS Macintosh HD           *249.8 GB   disk1
                                    Logical Volume on disk0s2
                                    A0A0A0A0-B1B1-C2C2-D3D3-E4E4E4E4E4E4
                                    Unencrypted
   /dev/disk2
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:      GUID_partition_scheme                        *16.0 GB    disk2
      1:                        EFI EFI                     209.7 MB   disk2s1
      2:                  Apple_HFS Backups                 15.7 GB    disk2s2
   /dev/disk3
      #:                       TYPE NAME                    SIZE       IDENTIFIER
      0:     Apple_partition_scheme                        *4.0 GB     disk3
      1:        Apple_partition_map                         4.1 KB     disk3s1
      2:                  Apple_HFS                         2.3 MB     disk3s2
   ```

   In my case, I'm targeting `/dev/disk3`.  Obviously, from this point out, replace the disk number as needed.

0. Unmount the USB device:

   ```sh
   ~ ❯❯❯ diskutil unmountDisk /dev/disk3
   Unmount of all volumes on disk3 was successful
   ```

   (replace N with the disk number from the last command; in the previous example, N would be 2).

0. Use the `dd` command to write the contents of the newly generated `.img` file to the USB device:

   ```sh
   ~ ❯❯❯ sudo dd if=output.img.dmg of=/dev/rdisk3 bs=1m
   1555+1 records in
   1555+1 records out
   1631322112 bytes transferred in 328.764960 secs (4961971 bytes/sec)
   ```
    
   Helpful tips about the `dd` command:
   - Using `/dev/rdisk` instead of `/dev/disk` may be faster
   - If you see the error `dd: Invalid number '1m'`, you are using GNU dd. Use the same command but replace `bs=1m` with `bs=1M`
   - If you see the error `dd: /dev/diskN: Resource busy`, make sure the disk is not in use. Start the 'Disk Utility.app' and unmount (don't eject) the drive

0. Eject and remove the USB device from the computer:

   ```sh
   ~ ❯❯❯ diskutil unmountDisk /dev/disk3
   Unmount of all volumes on disk3 was successful
   ```
