## Домашняя работа к занятию "3.5. Файловые системы"

1. Ознакомился. 
2. Не могут. Потому что по сути это только ссылки, а права доступа и владелец назначается самому объекту.
3. Сделано.
4. 
```
Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): e
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048): 2048
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Extended' and of size 2 GiB.
Command (m for help): n
Partition type
   p   primary (0 primary, 1 extended, 3 free)
   l   logical (numbered from 5)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

```
5. 
```
 sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xbc63b7c2

Old situation:

Device     Boot Start     End Sectors Size Id Type
/dev/sdc1        2048 4196351 4194304   2G  5 Extended

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xbc63b7c2.
/dev/sdc1: Created a new partition 1 of type 'Extended' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xbc63b7c2

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G  5 Extended
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.


lsblk -tf
NAME                      ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED       RQ-SIZE  RA WSAME FSTYPE      LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
loop0                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/core18/2128
loop1                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/lxd/21029
loop3                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/core18/2344
loop4                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/snapd/15177
loop5                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/core20/1405
loop6                             0    512      0     512     512    1 mq-deadline     256 128    0B squashfs                                                       0   100% /snap/lxd/22753
sda                               0    512      0     512     512    1 mq-deadline      64 128    0B
├─sda1                            0    512      0     512     512    1 mq-deadline      64 128    0B
├─sda2                            0    512      0     512     512    1 mq-deadline      64 128    0B ext4              6062f85a-eb61-4c49-900d-65a91b7edafb    802.6M    11% /boot
└─sda3                            0    512      0     512     512    1 mq-deadline      64 128    0B LVM2_member       sDUvKe-EtCc-gKuY-ZXTD-1B1d-eh9Q-XldxLf
  └─ubuntu--vg-ubuntu--lv         0    512      0     512     512    1                 128 128    0B ext4              4855fb55-feed-4397-8ed6-ad6ccc89ef59     25.6G    12% /
sdb                               0    512      0     512     512    1 mq-deadline      64 128    0B
├─sdb1                            0    512      0     512     512    1 mq-deadline      64 128    0B
└─sdb2                            0    512      0     512     512    1 mq-deadline      64 128    0B
sdc                               0    512      0     512     512    1 mq-deadline      64 128    0B
├─sdc1                            0    512      0     512     512    1 mq-deadline      64 128    0B
└─sdc2                            0    512      0     512     512    1 mq-deadline      64 128    0B

```
6. 
```
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: partition table exists on /dev/sdb1
mdadm: partition table exists on /dev/sdb1 but will be lost or
       meaningless after creating array
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: partition table exists on /dev/sdc1
mdadm: partition table exists on /dev/sdc1 but will be lost or
       meaningless after creating array
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.


```
7. 
```

sudo mdadm --create --verbose /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
lsblk -tf
NAME                      ALIGNMENT MIN-IO  OPT-IO PHY-SEC LOG-SEC ROTA SCHED       RQ-SIZE   RA WSAME FSTYPE            LABEL     UUID                                   FSAVAIL FSUSE% MOUNTPOINT
loop0                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core18/2128
loop1                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/lxd/21029
loop3                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core18/2344
loop4                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/snapd/15177
loop5                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core20/1405
loop6                             0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/lxd/22753
sda                               0    512       0     512     512    1 mq-deadline      64  128    0B
├─sda1                            0    512       0     512     512    1 mq-deadline      64  128    0B
├─sda2                            0    512       0     512     512    1 mq-deadline      64  128    0B ext4                        6062f85a-eb61-4c49-900d-65a91b7edafb    802.6M    11% /boot
└─sda3                            0    512       0     512     512    1 mq-deadline      64  128    0B LVM2_member                 sDUvKe-EtCc-gKuY-ZXTD-1B1d-eh9Q-XldxLf
  └─ubuntu--vg-ubuntu--lv         0    512       0     512     512    1                 128  128    0B ext4                        4855fb55-feed-4397-8ed6-ad6ccc89ef59     25.6G    12% /
sdb                               0    512       0     512     512    1 mq-deadline      64  128    0B
├─sdb1                            0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:0 24bb4125-5eba-a40e-76fc-0ad790e6facd
│ └─md0                           0    512       0     512     512    1                 128  128    0B
└─sdb2                            0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:1 f5de1362-93e0-8a96-e74e-861b399c4373
  └─md1                           0 524288 1048576     512     512    1                 128 2048    0B
sdc                               0    512       0     512     512    1 mq-deadline      64  128    0B
├─sdc1                            0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:0 24bb4125-5eba-a40e-76fc-0ad790e6facd
│ └─md0                           0    512       0     512     512    1                 128  128    0B
└─sdc2                            0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:1 f5de1362-93e0-8a96-e74e-861b399c4373
  └─md1                           0 524288 1048576     512     512    1                 128 2048    0B

```

8. 
```
 sudo pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
  
   sudo pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               ubuntu-vg
  PV Size               <63.00 GiB / not usable 0
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              16127
  Free PE               8063
  Allocated PE          8064
  PV UUID               sDUvKe-EtCc-gKuY-ZXTD-1B1d-eh9Q-XldxLf

  "/dev/md0" is a new physical volume of "<2.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/md0
  VG Name
  PV Size               <2.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               mPOHEu-pRxp-uKZs-fEFS-Pb1i-ErwM-xqyBNo

  "/dev/md1" is a new physical volume of "1018.00 MiB"
  --- NEW Physical volume ---
  PV Name               /dev/md1
  VG Name
  PV Size               1018.00 MiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               hWYdFH-2Pt7-yS2A-qtdR-DrY2-saEx-nM2usc

```
9.
``` 
 sudo vgcreate raid-vg /dev/md0 /dev/md1
  Volume group "raid-vg" successfully created
  
 sudo pvscan
  PV /dev/sda3   VG ubuntu-vg       lvm2 [<63.00 GiB / <31.50 GiB free]
  PV /dev/md0    VG raid-vg         lvm2 [<2.00 GiB / <2.00 GiB free]
  PV /dev/md1    VG raid-vg         lvm2 [1016.00 MiB / 1016.00 MiB free]
  Total: 3 [65.98 GiB] / in use: 3 [65.98 GiB] / in no VG: 0 [0   ]
```

10. 
````
 sudo lvcreate -n lv1-on-raid0 -L 100M raid-vg /dev/md1
  Logical volume "lv1-on-raid0" created.
````
11. 
```
 sudo mkfs.ext4 /dev/mapper/raid--vg-lv1--on--raid0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

```
12. По невнимательности примонтировал раздел в /dev (на мой взгляд логично, что диски в dev, обнаружил позже, что в задании указана папкп /tmp - переделывать не стал.)
```
 sudo mount /dev/mapper/raid--vg-lv1--on--raid0 /dev/new
vagrant@vagrant:~$ df -h
Filesystem                           Size  Used Avail Use% Mounted on
udev                                 447M     0  447M   0% /dev
tmpfs                                 99M 1012K   98M   2% /run
/dev/mapper/ubuntu--vg-ubuntu--lv     31G  3.7G   26G  13% /
tmpfs                                491M     0  491M   0% /dev/shm
tmpfs                                5.0M     0  5.0M   0% /run/lock
tmpfs                                491M     0  491M   0% /sys/fs/cgroup
/dev/loop0                            56M   56M     0 100% /snap/core18/2128
/dev/loop1                            71M   71M     0 100% /snap/lxd/21029
/dev/sda2                            976M  107M  803M  12% /boot
vagrant                              932G  419G  514G  45% /vagrant
/dev/loop3                            56M   56M     0 100% /snap/core18/2344
tmpfs                                 99M     0   99M   0% /run/user/1000
/dev/loop4                            44M   44M     0 100% /snap/snapd/15177
/dev/loop5                            62M   62M     0 100% /snap/core20/1405
/dev/loop6                            68M   68M     0 100% /snap/lxd/22753
/dev/mapper/raid--vg-lv1--on--raid0   93M   72K   86M   1% /dev/new

```
13. 
```
wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /dev/new/test.gz
--2022-04-04 13:27:00--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22320912 (21M) [application/octet-stream]
Saving to: ‘/dev/new/test.gz’

/dev/new/test.gz                                     100%[====================================================================================================================>]  21.29M  5.44MB/s    in 3.9s

2022-04-04 13:27:04 (5.41 MB/s) - ‘/dev/new/test.gz’ saved [22320912/22320912]

```
14. 
```
 lsblk
NAME                          MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                           7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                           7:1    0 70.3M  1 loop  /snap/lxd/21029
loop3                           7:3    0 55.5M  1 loop  /snap/core18/2344
loop4                           7:4    0 43.6M  1 loop  /snap/snapd/15177
loop5                           7:5    0 61.9M  1 loop  /snap/core20/1405
loop6                           7:6    0 67.8M  1 loop  /snap/lxd/22753
sda                             8:0    0   64G  0 disk
├─sda1                          8:1    0    1M  0 part
├─sda2                          8:2    0    1G  0 part  /boot
└─sda3                          8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv     253:0    0 31.5G  0 lvm   /
sdb                             8:16   0  2.5G  0 disk
├─sdb1                          8:17   0    2G  0 part
│ └─md0                         9:0    0    2G  0 raid1
└─sdb2                          8:18   0  511M  0 part
  └─md1                         9:1    0 1018M  0 raid0
    └─raid--vg-lv1--on--raid0 253:1    0  100M  0 lvm   /dev/new
sdc                             8:32   0  2.5G  0 disk
├─sdc1                          8:33   0    2G  0 part
│ └─md0                         9:0    0    2G  0 raid1
└─sdc2                          8:34   0  511M  0 part
  └─md1                         9:1    0 1018M  0 raid0
    └─raid--vg-lv1--on--raid0 253:1    0  100M  0 lvm   /dev/new

```
15. 
```

gzip -t /dev/new/test.gz
vagrant@vagrant:~$ echo $?
0

```
16. 
```

 sudo pvmove -v /dev/md1 /dev/md0
  Executing: /sbin/modprobe dm-mirror
  Archiving volume group "raid-vg" metadata (seqno 2).
  Creating logical volume pvmove0
  activation/volume_list configuration setting not defined: Checking only host tags for raid-vg/lv1-on-raid0.
  Moving 25 extents of logical volume raid-vg/lv1-on-raid0.
  activation/volume_list configuration setting not defined: Checking only host tags for raid-vg/lv1-on-raid0.
  Creating raid--vg-pvmove0
  Loading table for raid--vg-pvmove0 (253:2).
  Loading table for raid--vg-lv1--on--raid0 (253:1).
  Suspending raid--vg-lv1--on--raid0 (253:1) with device flush
  Resuming raid--vg-pvmove0 (253:2).
  Resuming raid--vg-lv1--on--raid0 (253:1).
  Creating volume group backup "/etc/lvm/backup/raid-vg" (seqno 3).
  activation/volume_list configuration setting not defined: Checking only host tags for raid-vg/pvmove0.
  Checking progress before waiting every 15 seconds.
  /dev/md1: Moved: 12.00%
  /dev/md1: Moved: 100.00%
  Polling finished successfully.
  
  lsblk -tf
NAME                          ALIGNMENT MIN-IO  OPT-IO PHY-SEC LOG-SEC ROTA SCHED       RQ-SIZE   RA WSAME FSTYPE            LABEL     UUID                                   FSAVAIL FSUSE% MOUNTPOINT
loop0                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core18/2128
loop1                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/lxd/21029
loop3                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core18/2344
loop4                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/snapd/15177
loop5                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/core20/1405
loop6                                 0    512       0     512     512    1 mq-deadline     256  128    0B squashfs                                                                 0   100% /snap/lxd/22753
sda                                   0    512       0     512     512    1 mq-deadline      64  128    0B
├─sda1                                0    512       0     512     512    1 mq-deadline      64  128    0B
├─sda2                                0    512       0     512     512    1 mq-deadline      64  128    0B ext4                        6062f85a-eb61-4c49-900d-65a91b7edafb    802.6M    11% /boot
└─sda3                                0    512       0     512     512    1 mq-deadline      64  128    0B LVM2_member                 sDUvKe-EtCc-gKuY-ZXTD-1B1d-eh9Q-XldxLf
  └─ubuntu--vg-ubuntu--lv             0    512       0     512     512    1                 128  128    0B ext4                        4855fb55-feed-4397-8ed6-ad6ccc89ef59     25.6G    12% /
sdb                                   0    512       0     512     512    1 mq-deadline      64  128    0B
├─sdb1                                0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:0 24bb4125-5eba-a40e-76fc-0ad790e6facd
│ └─md0                               0    512       0     512     512    1                 128  128    0B LVM2_member                 mPOHEu-pRxp-uKZs-fEFS-Pb1i-ErwM-xqyBNo
│   └─raid--vg-lv1--on--raid0         0    512       0     512     512    1                 128 2048    0B ext4                        719a552b-ee01-44bb-a9de-b0844d7849fa     64.5M    23% /dev/new
└─sdb2                                0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:1 f5de1362-93e0-8a96-e74e-861b399c4373
  └─md1                               0 524288 1048576     512     512    1                 128 2048    0B LVM2_member                 hWYdFH-2Pt7-yS2A-qtdR-DrY2-saEx-nM2usc
sdc                                   0    512       0     512     512    1 mq-deadline      64  128    0B
├─sdc1                                0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:0 24bb4125-5eba-a40e-76fc-0ad790e6facd
│ └─md0                               0    512       0     512     512    1                 128  128    0B LVM2_member                 mPOHEu-pRxp-uKZs-fEFS-Pb1i-ErwM-xqyBNo
│   └─raid--vg-lv1--on--raid0         0    512       0     512     512    1                 128 2048    0B ext4                        719a552b-ee01-44bb-a9de-b0844d7849fa     64.5M    23% /dev/new
└─sdc2                                0    512       0     512     512    1 mq-deadline      64  128    0B linux_raid_member vagrant:1 f5de1362-93e0-8a96-e74e-861b399c4373
  └─md1                               0 524288 1048576     512     512    1                 128 2048    0B LVM2_member                 hWYdFH-2Pt7-yS2A-qtdR-DrY2-saEx-nM2usc

```
17. 
```

sudo mdadm --fail /dev/md0 /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md0
vagrant@vagrant:~$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md1 : active raid0 sdc2[1] sdb2[0]
      1042432 blocks super 1.2 512k chunks

md0 : active raid1 sdc1[1](F) sdb1[0]
      2094080 blocks super 1.2 [2/1] [U_]

unused devices: <none>

```
18. 
```
 dmesg -T | grep raid1
[Mon Apr  4 10:21:07 2022] md/raid1:md0: not clean -- starting background reconstruction
[Mon Apr  4 10:21:07 2022] md/raid1:md0: active with 2 out of 2 mirrors
[Mon Apr  4 13:39:14 2022] md/raid1:md0: Disk failure on sdc1, disabling device.
                           md/raid1:md0: Operation continuing on 1 devices.
```
19. 
```
vagrant@vagrant:~$ gzip -t /dev/new/test.gz
vagrant@vagrant:~$ echo $?
0
```
20. 
```
vagrant destroy
```