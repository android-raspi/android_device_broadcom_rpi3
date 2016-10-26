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

# Inherit device parts
$(call inherit-product, device/broadcom/rpi3/device.mk)

# Override Product Name for AOSP
PRODUCT_NAME := aosp_rpi3
PRODUCT_DEVICE := rpi3
PRODUCT_BRAND := Broadcom
PRODUCT_MODEL := Raspberry Pi 3
PRODUCT_MANUFACTURER := Broadcom

PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREBUILT_DPI := tvdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi
PRODUCT_CHARACTERISTICS := tv
