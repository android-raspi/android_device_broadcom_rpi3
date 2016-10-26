LOCAL_PATH := $(call my-dir)

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/rpi-boot/zImage

compressed_ramdisk := $(PRODUCT_OUT)/rpi-boot/ramdisk.img
$(compressed_ramdisk): $(INSTALLED_RAMDISK_TARGET)
	zcat $< > $@

TARGET_KERNEL_BINARIES: $(KERNEL_OUT) $(KERNEL_CONFIG) $(KERNEL_HEADERS_INSTALL) $(compressed_ramdisk)
	$(MAKE) $(MAKE_FLAGS) -C $(KERNEL_SRC) O=$(KERNEL_OUT) ARCH=$(KERNEL_ARCH) $(KERNEL_CROSS_COMPILE) $(TARGET_PREBUILT_INT_KERNEL_TYPE)
	$(MAKE) $(MAKE_FLAGS) -C $(KERNEL_SRC) O=$(KERNEL_OUT) ARCH=$(KERNEL_ARCH) $(KERNEL_CROSS_COMPILE) dtbs
	$(MAKE) $(MAKE_FLAGS) -C $(KERNEL_SRC) O=$(KERNEL_OUT) ARCH=$(KERNEL_ARCH) $(KERNEL_CROSS_COMPILE) modules && \
	$(MAKE) $(MAKE_FLAGS) -C $(KERNEL_SRC) O=$(KERNEL_OUT) INSTALL_MOD_PATH=../../$(KERNEL_MODULES_INSTALL) ARCH=$(KERNEL_ARCH) $(KERNEL_CROSS_COMPILE) modules_install && \
		$(mv-modules) && $(clean-module-folder)

$(INSTALLED_BOOTIMAGE_TARGET): $(INSTALLED_KERNEL_TARGET)
	@echo -e ${CL_CYN}"----- Copying boot image ------"${CL_RST}
	$(hide) mkdir -p $(PRODUCT_OUT)/rpi-boot/overlays
	$(hide) cp $(KERNEL_OUT)/arch/$(TARGET_ARCH)/boot/dts/bcm2710-rpi-3-b.dtb $(PRODUCT_OUT)/rpi-boot/
	$(hide) cp $(KERNEL_OUT)/arch/$(TARGET_ARCH)/boot/dts/overlays/vc4-kms-v3d.dtbo $(PRODUCT_OUT)/rpi-boot/overlays/
	$(ACP) -fp $< $@
