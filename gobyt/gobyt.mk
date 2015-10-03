#
# Copyright (C) 2009 The Android Open Source Project
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
#

# This is a build configuration for a full-featured build of the
# Open-Source part of the tree. It's geared toward a US-centric
# build quite specifically for the emulator, and might not be
# entirely appropriate to inherit from for on-device configurations.
ifdef NET_ETH0_STARTONBOOT
  PRODUCT_PROPERTY_OVERRIDES += net.eth0.startonboot=1
endif

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/aicVM/gobyt/device.mk)

PRODUCT_NAME := gobyt
PRODUCT_DEVICE := gobyt
PRODUCT_MODEL := AiC ('Tablet' version)

PRODUCT_COPY_FILES += \
    device/aicVM/goby/vold.fstab:system/etc/vold.fstab \
    device/aicVM/goby/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \


