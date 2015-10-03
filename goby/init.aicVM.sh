#!/system/bin/sh

# Disable cursor blinking - Thanks android-x86 :-)
echo -e '\033[?17;0;0c' > /dev/tty0

(

unset LD_PRELOAD

vbox_graph_mode="800x600-16"
vbox_dpi=`getprop persist.aicvm.vbox_dpi 160`

prop_hardware_opengl=`getprop persist.aicvm.hardware_opengl 0`
# Starting eth0 management
# First check if eth0 is 'plugged'
if [ "$prop_hardware_opengl" = "1" ]; then
  /system/bin/netcfg eth0 up
    while ! ip addr show dev eth0 | grep 'inet ' &> /dev/null
    do
      echo  "Trying to get an ip address"
      /system/bin/netcfg eth0 dhcp
    done
    IPETH0=(`ifconfig eth0`)
    IPMGMT=${IPETH0[2]}
    echo "IP Management : $IPMGMT"
    log -p D -t init_aicvm "IP Management : $IPMGMT"
    ip link set eth0 mtu 1400
    ip link set eth1 mtu 1400
    ip link set eth2 mtu 1400
else
  (
    /system/bin/netcfg eth0 dhcp
    IPETH0=(`ifconfig eth0`)
    IPMGMT=${IPETH0[2]}
    echo "IP Management : $IPMGMT"
    log -p D -t init_aicvm "IP Management : $IPMGMT"
    ip link set eth0 mtu 1400
    ip link set eth1 mtu 1400
    ip link set eth2 mtu 1400
  )&
fi

# Load parameters from virtualbox guest properties

prop_vkeyboard_mode=`getprop persist.aicvm.vkeyboard_mode`
if [ -n "$prop_vkeyboard_mode" ]; then
  vkeyboard_mode="$prop_vkeyboard_mode"
  setprop aicVM.vkeyboard_mode "$prop_vkeyboard_mode"
    log -p D -t init_aicvm "vkeyboard_mode = $prop_vkeyboard_mode"
fi

prop_su_bypass=`getprop persist.aicvm.su_bypass`
if [ $prop_su_bypass ]; then
  setprop aicd.su.bypass 1
  log -p D -t init_aicvm "su bypass enabled"
fi

# Setting Device Id system properties from VirtualBox properties
prop_device_id=$(getprop persist.aicvm.aic_device_id "[none]")
if [ "$prop_device_id" =  "[none]" ]; then
  # Default value if unset
  setprop aicd.device.id "00000000000000"
  log -p D -t init_aicvm "AiC Device ID reset"
else
  # Set user defined value. "[none]" keyword means empty value
  setprop aicd.device.id "$prop_device_id"
  log -p D -t init_aicvm "AiC Device ID set to $prop_device_id"
fi

# UVESAFB
modprobe uvesafb mode_option="$vbox_graph_mode" scroll=redraw

setprop ro.sf.lcd_density $vbox_dpi
setprop qemu.sf.lcd_density $vbox_dpi
log -p D -t init_aicvm "Device DPI set to $vbox_dpi"

if [ "$prop_hardware_opengl" = "1" ]; then
    setprop aicVM.gles 1
    prop_hardware_opengl_disable_render=`getprop persist.aicvm.hardware_opengl_disable_render 0`
    if [ -z "$prop_hardware_opengl_disable_render" -o "$prop_hardware_opengl_disable_render" != "1" ]; then
      setprop aicVM.gles.renderer 1
      log -p D -t init_aicvm "OpenGL Renderer enabled"
    fi
fi

setprop wifi.interface eth1
setprop wlan.interface eth1
setprop wifi.interface.mac `cat /sys/class/net/eth1/address`

log -p I -t init_aicvm "AiC boot script finished"
setprop aicVM.inited 1

ADB_KEYS=/data/misc/adb/adb_keys
# Legacy API - easier than OpenStack + JSON parsing
[ -f $ADB_KEYS ] || wget http://169.254.169.254/2009-04-04/meta-data/public-keys/0/openssh-key -O $ADB_KEYS 2>/dev/null

) 2>&1 > /dev/ttyS0

