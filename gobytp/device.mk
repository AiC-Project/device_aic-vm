PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS += device/aicVM/gobytp/overlay

$(call inherit-product, device/aicVM/goby/device.mk)

PRODUCT_PACKAGES += gsmd
