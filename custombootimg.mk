# Copyright (c) 2006, Broadcom Corporation.
# Copyright (c) 2014, The Android Open Source Project
# Copyright (c) 2015, Raspberry Pi (Trading) Ltd
#
# All rights reserved.
# 
# Redistribution.  Redistribution and use in binary form, without
# modification, are permitted provided that the following conditions are
# met:
# 
# * This software may only be used for the purposes of developing for, 
#   running or using a Raspberry Pi device.
# * Redistributions must reproduce the above copyright notice and the
#   following disclaimer in the documentation and/or other materials
#   provided with the distribution.
# * Neither the name of Broadcom Corporation nor the names of its suppliers
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
# 
# DISCLAIMER.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.

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
