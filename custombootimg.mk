# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

DEVICE_PATH := $(ANDROID_BUILD_TOP)/device/broadcom/$(TARGET_DEVICE)

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
	@echo -e ${CL_CYN}"----- Creating boot image ------"${CL_RST}
	$(hide) mkdir -p $(PRODUCT_OUT)/rpi-boot/overlays
	$(hide) cp $(KERNEL_OUT)/arch/$(TARGET_ARCH)/boot/dts/bcm2710-rpi-3-b.dtb $(PRODUCT_OUT)/rpi-boot/
	$(hide) cp $(KERNEL_OUT)/arch/$(TARGET_ARCH)/boot/dts/overlays/vc4-kms-v3d.dtbo $(PRODUCT_OUT)/rpi-boot/overlays/
	$(hide) cp -Rf $(DEVICE_PATH)/boot/* $(PRODUCT_OUT)/rpi-boot/
	$(ACP) -fp $< $@
