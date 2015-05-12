---
layout: post102
title:  Advanced Tuning Guide
categories: XAP102ADM
parent: memoryxtend-ssd.html
weight: 300
---


{% summary %}  {% endsummary %}

{%comment%}
# Introduction

SSD drives have been out for more than five years now, and ,as their price comes down and performance goes up, are increasingly being used in all types of computing devices. I bought my first PCIe-based RAID more than three years ago, and currently I have only one hard drive; all my machines use SSD.

As SSD adoption grew manufacturers continued to optimize the technology. The first step was MLC or multi-level cell, which dramatically reduced the cost of NAND flash. Subsequent developments have improved drive life, increased performance, and further reduced cost. Consumer grade drives now cost approximately $0.5 per gigabyte.

Along the way certain observations were made. The most important observation is that flash based drives do not deteriorate as quickly as was once believed, and their failure rate is less than originally expected, making them well suited for enterprise environments.

But there are other important factors, principally latency. PCIe-based devices have lower latency than SAS/SATA devices, and have equal or sometimes greater throughput. Current third generation PCIe lanes are 8Gbit/sec, which when multiplied by eight, ie. PCIe x8, give 64Gb/sec, or 8GB/sec. None of this is particularly helpful if it can’t get off the machine, so expect to see and use 10G Ethernet as well.
{%endcomment%}


# Configuration


In order to sustain read/write speeds anywhere near RAM-based performance more than a single SSD is required. Current drives can at best yield ~500MB write/~550 MB read at 50k IOPs/sec.

{%comment%}
Do not be deceived by manufacturers claims that their individual SAS/SATA drives are capable of 100k IOPs; this is a burst rate and not sustainable. In order to achieve sufficient read-write rates we’re going to need to use multiple drives.
{%endcomment%}

In order to determine what level of speed is required in any particular project, the first value should be the number of reads and/or write required per second. Secondly, the percentage of writes versus reads is also very important, as when the device writes and reads at the same time the overall performance tends to degrade, to the point where reads can only be performed at the write rate. There are exceptions here, specifically with regards to SAS/SATA SSDs, which can come in different flavors, some tuned for reads, some balanced, and others write-enhanced.

Here is an example of a machine, which has two SSDs in RAID0:

{%highlight bash%}
sudo hdparm -tT /dev/mapper/isw_bhjbdcgibg_Volume0:

 Timing cached reads:   12760 MB in  1.99 seconds = 6396.92 MB/sec
 Timing buffered disk reads: 2630 MB in  3.00 seconds = 876.09 MB/sec
{%endhighlight%}

This means the machine can read one CD from the volume in one second. If you have a magnetic disk you should probably see something like ~100 MB/sec.

{%comment%}
Yes, that means my laptop can read one CD from the volume in one second. If you have a magnetic disk you should probably see something like ~100 MB/sec.
{%endcomment%}

### Aggregation

Most installations will require greater read/write performance than that offered by a single drive. This necessarily involves RAID technology. There are only two RAID designations we will be considering, RAID0 and RAID10. RAID0 means that data being stored is separated, or 'striped', ie. partitioned, to all the drives. RAID10 is the same, with the exception that every stripe has a backup.

{%comment%}
The MongoDB installation I use at home (RAID10) has 4 drives, and uses the HBA (Host Bus Adapter) to mirror 0/1 & 2/3, and then splits the data onto these two stripes using 'mdadm' (multi-disk administrator). This is the tool that SanDisk uses internally for testing, as an array can be taken down and reconfigured very easily. This requires one core, however, so installations using only 4 cores may wish to employ a dedicated RAID controller, as opposed to an HBA. In such instances all management functions should be turned off, as they will negatively impact performance.


Although we don't yet have conclusive test data, it is believed that performance will be better using 4 drives aggregated into RAID0 and then split into 4 partitions, than it would using each drive separately. Brian O'Krafka believes that the optimal size might be 8 drives, or 16 if using RAID10. This has implications for stripe size, which determines how many bytes are used across the stripes for data storage. 8 drives would probably benefit most from using 4k or 8k-byte chunks, meaning a 32k or 64k-byte stripe. As ZetaScale manages storage internally this should not affect data storage in the manner it does normally, where storing one byte would require 64k.

Whether or not any given installation uses aggregation will depend on a number of things. Although this has yet to be conclusively proven one way or another, our estimation is that 1:20 is probably the ideal RAM:SSD ratio. Given that we are seeing a lot of systems using ~8GB this would indicate one 200GB SSD per partition. However the performance, specifically for write operations, may not meet the client's requirements, and thus multiple drives might be required per parition. There is a small distribution factor involved when using aggregation; not all partitions will be writing at the same rate, and so any leftover performance from one partition will be automatically given to other partitions when available. In this particular example 16x RAID10 would support 4 partitions (2x per partition) with backups; there would be ~380GB backing up each 8GB space partition.
{%endcomment%}


#	Operating System

##	Linux

Currently this only works on Linux. In the future it should be possible to run on *BSD and Solaris, but Windows is not definite. The Blobstore installer should install all of its dependencies and configure itself.


# Tools and Utilities

##	Installing Linux Tools

Firstly, keep in mind that these commands may or may not exist on the machine(s) you are using and you will need to install them if they don't. The basics are as follows (and yes, most of these commands need to be ‘sudo’):

{%highlight bash%}
sudo yum search 'command'  - this command helps you find the name of a package that contains certain things, ie. libraries or executables

sudo yum install 'package' - this command installs the specified package
{%endhighlight%}

##	Required Utilities

The following tools are necessary:

{%highlight bash%}
sudo parted <device> - provides the same functionality as fdisk but knows about GPT

sudo mdadm <> - creates, modifies, or destroys a kernel-based raid device

sudo hdparm -tT <device> - gives ‘ballpark’ drive performance rating

sudo iostat -h -x -d /dev/sdb 1 - gives partition level statistics for a device, updated every second
{%endhighlight%}

##	Creating MDADM RAID0/RAID10 Devices

The instructions below refer to the following commands: parted/gdisk, hdparm, iostat, mdadm

These are the actual instructions you should issue to create an array using mdadm; the example uses 8 drives. Ideally you will use 4kb per drive to determine the stripe size, so in this case 8x4 = 32, OR 4x4 = 16.

#### this is for a non-replicated array - it is call 8,0
{%highlight bash%}
mdadm --create /dev/blobstore --level=raid0 --chunk=32KB --raid-devices=8 /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh
{%endhighlight%}

#### this is for a replicated (backup) array - it is call 4,1
{%highlight bash%}
mdadm --create /dev/blobstore --level=raid10 --chunk=16KB --raid-devices=8 /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh
{%endhighlight%}

##	Partitioning

Here are the specific instructions for using the Fusion-io cards:

{%highlight bash%}
1) 'fparted /dev/fioa' - then 'mklabel gpt' - this only needs to be done once

2) 'gdisk /dev/fioa' - please leave 1mb free at the beginning and create four primary partitions - i have not installed gdisk yet but willl do so later.

if for some reason you reboot the machine you will need to re-insert the module:

'insmod /lib/modules/2.6.32-431.el6.x86_64/extra/fio/iomemory-vsl.ko'

{%endhighlight%}

if you do double-check that '/dev/fioa' exists after the command returns. if it is partitioned there should be /dev/fioa1-4 as well.


#	Monitoring

Issuing the following command will return drive and partition statistics for a given device updated every second

{%highlight bash%}
iostat -h -x -p /dev/sdb 1
{%endhighlight%}

#	Performance

These are the recommended BIOS settings. Please note that they are somewhat specific to their devices.

1) Disable all C-states - no low power states

2) Set Power to Max Performance

3) Virtualization - disable all

4) Hyperthreading - disable

These settings, or a slightly different version, can be found in the following document [{%pdf%}](http://www.vmware.com/a/assets/vmmark/pdf/2014-02-18-HP-ProLiantDL580G8.pdf)


