url_buildroot = https://buildroot.org/downloads/buildroot-2017.02.9.tar.gz
archive_buildroot = buildroot.tar.gz
system_image = stm32f746g-disco_system.uImage
dir_download = downloads
dir_configs = configs
dir_buildroot = buildroot
dir_publish = /srv/tftp/stm32f746/

bootstrap:
	mkdir -p $(dir_download)
	mkdir -p $(dir_buildroot)
	wget -O $(dir_download)/$(archive_buildroot) $(url_buildroot)
	tar zxvf $(dir_download)/$(archive_buildroot) -C $(dir_buildroot) --strip-components=1
	cd $(dir_buildroot) && patch -p0 < ../patches/buildroot.002_openocd_version_0_10_0
	cd $(dir_buildroot) && patch -p0 < ../patches/buildroot.003_openocd_hash
	cp $(dir_configs)/buildroot $(dir_buildroot)/.config

build:
	make -C $(dir_buildroot)
	cp $(dir_buildroot)/output/images/stm32f746-disco.dtb ${dir_publish}/
	cp $(dir_buildroot)/output/images/zImage ${dir_publish}/

flash_bootloader:
	cd $(dir_buildroot)/output/build/host-openocd-0.10.0/tcl && ../../../host/usr/bin/openocd \
		-f board/stm32f7discovery.cfg \
		-c "program ../../../images/u-boot-spl.bin 0x08000000" \
		-c "program ../../../images/u-boot.bin 0x08008000" \
		-c "reset run" -c shutdown

clean:
	rm -rf $(dir_buildroot) $(dir_download)
