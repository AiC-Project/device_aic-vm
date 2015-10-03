#
# IA target for VitualBox
#

PRODUCT_MANUFACTURER := AiC
TARGET_ARCH=x86
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := x86
TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)
TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_32_BIT)
TARGET_ARCH_VARIANT=x86
TARGET_CPU_SMP := true
TARGET_PRELINK_MODULE := false
BOARD_MALLOC_ALIGNMENT := 16
BOARD_USE_LEGACY_UI := false
WITH_DEXPREOPT := true
TARGET_GCC_VERSION_EXP := 4.9
TARGET_COMPRESS_MODULE_SYMBOLS := false
TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := false
TARGET_HARDWARE_3D := false
BOARD_USES_GENERIC_AUDIO := false
USE_CAMERA_STUB := false
TARGET_PROVIDES_INIT_RC := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_BOOTIMAGE_USE_EXT2 := true
AICVM_YV12_NOT_SUPPORTED := true
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USES_64_BIT_BINDER := false

# For VirtualBox and likely other emulators
BOARD_INSTALLER_CMDLINE := console=ttyS0
BOARD_KERNEL_CMDLINE := androidboot.console=ttyS0 console=ttyS0 androidboot.hardware=goby androidboot.selinux=permissive
TARGET_USE_DISKINSTALLER := true

#TARGET_DISK_LAYOUT_CONFIG := build/target/board/vbox_x86/disk_layout.conf
BOARD_BOOTIMAGE_MAX_SIZE := 8388608
BOARD_SYSLOADER_MAX_SIZE := 7340032
BOARD_FLASH_BLOCK_SIZE := 512
# 2.5GB for /data
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2684354560
# 500M
BOARD_INSTALLERIMAGE_PARTITION_SIZE := 524288000
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
# 1GB for /system
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824

BUILD_ARM_FOR_X86 := false


#Use Chrome as default HTTP
HTTP := chrome
JS_ENGINE := v8

#Wifi
BOARD_WPA_SUPPLICANT_DRIVER := WIRED
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := eth1

#Bluetooth
BOARD_HAVE_BLUETOOTH := false

#OpenGL
BUILD_EMULATOR_OPENGL := true
BUILD_EMULATOR_OPENGL_DRIVER := true
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS ?= 3

#SuperUser
SUPERUSER_PACKAGE := com.aic.superuser

BOARD_SEPOLICY_DIRS += build/target/board/generic/sepolicy
BOARD_SEPOLICY_DIRS += build/target/board/generic_x86/sepolicy
BOARD_SEPOLICY_DIRS += device/aicVM/goby/sepolicy

BOARD_SEPOLICY_UNION += \
        bootanim.te \
        device.te \
        domain.te \
        file.te \
        file_contexts \
        gsmd.te \
        healthd.te \
        init.te \
        installd.te \
        netd.te \
        qemud.te \
        rild.te \
        shell.te \
        surfaceflinger.te \
        system_server.te \
        ueventd.te \
        zygote.te

BOARD_SEPOLICY_UNION += \
        dns.te \
        init_aicvm.te \
        local_opengl.te \
        local_camera.te \
        local_gps.te \
        packages.te \
        vinput.te \
        vinput_seamless.te


#BOARD_SEPOLICY_UNION += \
#        bootanim.te \
#        device.te \
#        domain.te \
#        file.te \
#        file_contexts \
#        healthd.te \
#        installd.te \
#        qemud.te \
#         rild.te \
#        shell.te \
#        surfaceflinger.te \
#        system_server.te \
#        zygote.te


BUILD_EMULATOR_HOST_OPENGL := true
EMULATOR_BUILD_64BIT := true
EMUGL_BUILD_64BIT := true
