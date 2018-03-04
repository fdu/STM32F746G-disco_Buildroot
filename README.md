Linux on the STM32F746G Discovery board with Buildroot
======================================================

The project is a set of patches and configuration files to build a bootloader and a Linux based system image with a minimal root file system for the great [STM32F746G Discovery board](http://www.st.com/en/evaluation-tools/32f746gdiscovery.html).

Board peripherals support
-------------------------

See this [overview of board peripherals support](doc/Board_peripherals_support.md).


Build
-----

Let's download, extract and patch Buildroot:

`$ make bootstrap`


Then build:

`$ make build`


After the build, the directory `buildroot/output/images/` contains 
 - U-Boot images `u-boot-spl.bin` and `u-boot.bin`
 - compressed Linux kernel with linked RAM filesystem `zImage`
 - device tree blob `stm32f746-disco.dtb`

Run
---

Write U-Boot in the internal flash:

`$ make flash_bootloader`

U-Boot is configured to write the Linux kernel in the SPI flash is the user button (the blue one) is pressed during reset. It loads and flash the device tree blob image called `stm32f746/stm32f746-disco.dtb` and the kernel image called `stm32f746/zImage` over TFTP from a host with IP `192.168.201.6`.

![alt text](https://github.com/fdu/STM32F746G_Buildroot/blob/master/doc/stm32f746g-disco_linux.png)

Changelog
---------

* 0.3
  * U-Boot 2018.03-rc3
  * Linux 4.15.3
  * Overview of board peripherals support

* 0.2
  * Buildroot 2017.02.9
  * GCC 6.3.0
  * U-Boot 2018.03-rc2
  * Linux 4.15.3
  * Busybox 1.26.2

* 0.1
  * Buildroot 2017.02.9
  * GCC 4.4.1 (external)
  * U-Boot from Emcraft
  * Linux 2.6.33 from Emcraft with LCD driver
  * Busybox
  * OpenOCD 0.10.0
