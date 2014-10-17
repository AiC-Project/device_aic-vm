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

# This is a build configuration for the product aspects that
# are specific to the emulator.

DEVICE_PACKAGE_OVERLAYS		+= device/aicVM/goby/overlay

PRODUCT_PROPERTY_OVERRIDES := \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    wifi.interface=eth1 \
    persist.sys.timezone="Europe/Paris"

PRODUCT_AAPT_CONFIG := normal ldpi mdpi hdpi xhdpi xxhdpi

PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    device/aicVM/goby/fstab.goby:root/fstab.goby \
    device/aicVM/goby/vold.conf:system/etc/vold.conf \
    device/aicVM/goby/media_profiles.xml:system/etc/media_profiles.xml \
    device/aicVM/goby/media_codecs.xml:system/etc/media_codecs.xml \
    device/aicVM/goby/init.rc:root/init.rc \
    device/aicVM/goby/init.goby.rc:root/init.goby.rc \
    device/aicVM/goby/ueventd.goby.rc:root/ueventd.goby.rc \
    device/aicVM/goby/init.aicVM.sh:system/etc/init.aicVM.sh \
    device/aicVM/blob/bzImage:kernel \
    device/aicVM/goby/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/aicVM/blob/uvesafb.ko:system/lib/uvesafb.ko \
    frameworks/base/data/keyboards/qwerty.kl:system/usr/keylayout/AT_Translated_Set_2_keyboard.kl \
    device/aicVM/goby/aicVM_Virtual_Input.kl:system/usr/keylayout/aicVM_Virtual_Input.kl \
    device/aicVM/goby/wpa_supplicant.conf:data/misc/wifi/wpa_supplicant.conf \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    device/aicVM/goby/audio_policy.conf:system/etc/audio_policy.conf \
    device/aicVM/goby/aicVM_Virtual_Input.idc:system/usr/idc/aicVM_Virtual_Input.idc \
    device/aicVM/goby/excluded-input-devices.xml:system/etc/excluded-input-devices.xml \
    device/aicVM/goby/gps.conf:system/etc/gps.conf \
    device/aicVM/goby/install_packages.sh:system/etc/install_packages.sh \
    device/aicVM/goby/setup_dns.sh:system/etc/setup_dns.sh \


PRODUCT_PACKAGES += \
    audio.primary.goby \
    libaudioutils \
    CMFileManager \
    camera.goldfish.jpeg \
    camera.goby \
    local_camera \
    LegacyCamera \
    v86d \
    tinyplay \
    tinycap \
    tinymix \
    LiveWallpapersPicker \
    ApiDemos \
    GestureBuilder \
    CubeLiveWallpapers \
    aicVM-prop \
    vmconfig \
    ClipboardProxy \
    vinput \
    vinput_seamless \
    local_opengl \
    tcpdump \
    sensors.goby \
    setdpi \
    aicVM_setprop \
    make_ext4fs \
    gps.goby \
    local_gps \
    lib_renderControl_enc \
    libEGL_emulation \
    libGM_GLESv1_enc \
    libGM_GLESv2_enc \
    libGLESv1_CM_emulation \
    libGLESv2_emulation \
    libOpenglSystemCommon \
    gralloc.goby \
    libFFmpegExtractor \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec

$(call inherit-product-if-exists,frameworks/base/build/tablet-dalvik-heap.mk)
