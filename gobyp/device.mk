DEVICE_PACKAGE_OVERLAYS += device/aicVM/gobyp/overlay

$(call inherit-product, device/aicVM/goby/device.mk)

PRODUCT_PACKAGES += gsmd
