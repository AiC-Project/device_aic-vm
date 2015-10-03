PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS += device/aicVM/gobyt/overlay

$(call inherit-product, device/aicVM/goby/device.mk)
