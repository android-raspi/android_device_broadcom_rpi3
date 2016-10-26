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

USE_OEM_TV_APP := true

$(call inherit-product, device/google/atv/products/atv_base.mk)
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

RDIR := device/broadcom/rpi3/rootdir

DEVICE_PACKAGE_OVERLAYS += \
    device/broadcom/rpi3/overlay

# Device Init
PRODUCT_PACKAGES += \
    init.rpi3 \
    ueventd.rpi3 \
    init.usb.rpi3

# Display HAL
PRODUCT_PACKAGES += \
    libGLES_mesa \
    gralloc.$(TARGET_PRODUCT) \
    hwcomposer.$(TARGET_PRODUCT)

# WLAN
PRODUCT_PACKAGES += \
    p2p_supplicant.conf \
    hostapd \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    hardware/broadcom/wlan/bcmdhd/config/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

# Prebuilt files
PRODUCT_COPY_FILES += \
    $(RDIR)/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(RDIR)/system/etc/permissions/rpi3_core_hardware.xml:system/etc/permissions/rpi3_core_hardware.xml \
    $(RDIR)/system/etc/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Firmwares
PRODUCT_COPY_FILES += \
    $(RDIR)/system/etc/firmware/brcm/brcmfmac43430-sdio.bin:system/etc/firmware/brcm/brcmfmac43430-sdio.bin \
    $(RDIR)/system/etc/firmware/brcm/brcmfmac43430-sdio.txt:system/etc/firmware/brcm/brcmfmac43430-sdio.txt \
    $(RDIR)/system/etc/firmware/brcm/BCM43430A1.hcd:system/etc/firmware/brcm/BCM43430A1.hcd

# Camera
PRODUCT_COPY_FILES += \
    device/generic/goldfish/camera/media_profiles.xml:system/etc/media_profiles.xml \
    device/generic/goldfish/camera/media_codecs.xml:system/etc/media_codecs.xml

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.conf:system/etc/audio_effects.conf \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml

# Limit dex2oat threads to improve thermals
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-threads=2 \
    dalvik.vm.image-dex2oat-threads=4

# EGL depth
PRODUCT_PROPERTY_OVERRIDES += \
    egl.depth.value=24

# Wi-Fi interface name
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0
