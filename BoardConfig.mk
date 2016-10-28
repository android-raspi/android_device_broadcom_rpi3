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
