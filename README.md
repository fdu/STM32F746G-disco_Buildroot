Linux on the STM32F746G Discovery board with Buildroot
======================================================

The project is a set of patches and configuration files to build a bootloader and a Linux based system image with a minimal root file system for the great [STM32F746G Discovery board](http://www.st.com/en/evaluation-tools/32f746gdiscovery.html).

- Buildroot 2017.02.9
- GCC 4.4.1 (external)
- U-Boot from Emcraft
- Linux 2.6.33 from Emcraft with LCD driver
- Busybox
- OpenOCD 0.10.0

Build
-----

Let's download, extract and patch Buildroot:

`$ make bootstrap`


Then build:

`$ make build`


After the build, the directory `buildroot/output/images/` contains 
 - U-Boot `u-boot.bin` and its environment configuration `uboot-env.bin`
 - a U-Boot image `stm32f746g-disco_system.uImage` containing the Linux kernel, a RAM disk linked to it, and the device tree for this board

Run
---

Flash U-Boot:

`$ make flash_bootloader`


U-Boot is pre-configured to load a system image called `stm32f7/stm32f746g-disco_system.uImage` from over TFTP from a host with `IP 192.168.201.6` (change the configuration in `configs/uboot-env`). This image can be written to the embedded SPI flash with the command `update_spi` in U-Boot. After this, U-Boot can be configured to boot from the SPI with `boot_spi`. A framebuffer console is enabled by adding `console=tty0` to the boot arguments:

![alt text](https://github.com/fdu/STM32F746G_Buildroot/blob/master/doc/stm32f746g-disco_linux.png)

Boot log
--------

Output coming through USART6:
```
U-Boot 2010.03 (***)

CPU  : STM32F7 (Cortex-M7)
Freqs: SYSCLK=200MHz,HCLK=200MHz,PCLK1=50MHz,PCLK2=100MHz
Board: STM32F746 Discovery Rev 1.A, www.emcraft.com
DRAM:   8 MB
In:    serial
Out:   serial
Err:   serial
QSPI:  16 MB mapped at 0x90000000
Net:   STM32_MAC
Hit any key to stop autoboot:  0 
Booting from network...
Auto-negotiation...completed.
STM32_MAC: link UP (100/Full)
Using STM32_MAC device
TFTP from server 192.168.201.6; our IP address is 192.168.201.123
Filename 'stm32f7/stm32f746g-disco_system.uImage'.
Load address: 0xc0007fc0
Loading: T #################################################################
         ###############################
done
Bytes transferred = 1402248 (156588 hex)
## Booting kernel from Legacy Image at c0007fc0 ...
   Image Name:   
   Image Type:   ARM Linux Multi-File Image (uncompressed)
   Data Size:    1402184 Bytes =  1.3 MB
   Load Address: c0008000
   Entry Point:  c0008001
   Contents:
      Image 0: 1402176 Bytes =  1.3 MB
   Verifying Checksum ... OK
## Loading init Ramdisk from multi component Legacy Image at c0007fc0 ...
   Loading Multi-File Image ... OK
OK
WARNING: legacy format multi component image overwritten

Starting kernel ...

Linux version 2.6.33-arm1-linuxito-lcdfork (***) (collect2: ld returned 1 exit status) #45 Tue Jan 23 22:23:34 CET 2018
CPU: ARMv7-M Processor [410fc271] revision 1 (ARMv7M)
CPU: WBA data cache, WBA instruction cache
Machine: STMicro STM32
...
[load image and boot Linux kernel]
...
Freeing init memory: 340K
devpts: called with bogus options
Initializing random number generator... urandom start: failed.
done.
Starting network: run-parts: applet not found
FAIL
Starting telnetd: OK

Welcome to Buildroot
buildroot login: root
Jan  1 00:00:18 login[34]: root login on 'console'


BusyBox v1.26.2 (2018-01-23 22:07:12 CET) hush - the humble shell
Enter 'help' for a list of built-in commands.

~ #
```
