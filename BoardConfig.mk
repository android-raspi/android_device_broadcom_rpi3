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

TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := false

# ARM
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

# Kernel
TARGET_KERNEL_SOURCE := kernel/broadcom/rpi
TARGET_KERNEL_CONFIG := broadcom_rpi3_defconfig
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/raspberry-pi/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
KERNEL_TOOLCHAIN_PREFIX := arm-linux-gnueabihf-
BOARD_KERNEL_IMAGE_NAME := zImage

# Custom boot image
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := device/broadcom/rpi3/custombootimg.mk

# Broadcom Platform
BROADCOM_AOSP := true
TARGET_BOARD_PLATFORM := bcm2710
TARGET_COMPRESS_MODULE_SYMBOLS := false
TARGET_PRELINK_MODULE := false

# Partitions
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824 # 1GB
BOARD_CACHEIMAGE_PARTITION_SIZE := 134217728 # 128M
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 134217728 # 128M
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_MALLOC_ALIGNMENT := 16

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_USB_AUDIO := false

# Display
BOARD_EGL_CFG := device/broadcom/rpi3/rootdir/egl.cfg
BOARD_GPU_DRIVERS := vc4
USE_OPENGL_RENDERER := true
TARGET_USE_PAN_DISPLAY := true

# Wifi
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/firmware/brcm/brcmfmac43430-sdio.bin"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/brcm/brcmfmac43430-sdio.bin"

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/broadcom/rpi3/bluetooth
BOARD_CUSTOM_BT_CONFIG := device/broadcom/rpi3/bluetooth/vnd_rpi3.txt

# Camera
USE_CAMERA_STUB := true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

# SELinux
BOARD_SEPOLICY_DIRS := \
    device/broadcom/rpi3/sepolicy

# Props
TARGET_SYSTEM_PROP += device/broadcom/rpi3/system.prop
