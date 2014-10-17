#!/system/bin/sh

# Disable cursor blinking - Thanks android-x86 :-)
echo -e '\033[?17;0;0c' > /dev/tty0

(

unset LD_PRELOAD

vbox_graph_mode="800x600-16"
vbox_dpi="160"


prop_hardware_opengl=`/system/bin/aicVM-prop get hardware_opengl`
# Starting eth0 management
# First check if eth0 is 'plugged'
if [ $prop_hardware_opengl ]; then
  /system/bin/netcfg eth0 up
    while ! ip addr show dev eth0 | grep 'inet ' &> /dev/null
    do
      echo  "Trying to get an ip address"
      /system/bin/netcfg eth0 dhcp
    done
    IPETH0=(`ifconfig eth0`)
    IPMGMT=${IPETH0[2]}
    /system/bin/aicVM-prop set aicvm_ip_management $IPMGMT
    echo "IP Management : $IPMGMT"
  ip link set eth0 mtu 1400
  ip link set eth1 mtu 1400
  ip link set eth2 mtu 1400
else
  (
    /system/bin/netcfg eth0 dhcp
    IPETH0=(`ifconfig eth0`)
    IPMGMT=${IPETH0[2]}
    /system/bin/aicVM-prop set aicvm_ip_management $IPMGMT
    echo "IP Management : $IPMGMT"
    ip link set eth0 mtu 1400
    ip link set eth1 mtu 1400
    ip link set eth2 mtu 1400
  )&
fi

# Load parameters from virtualbox guest properties

prop_vbox_graph_mode=`/system/bin/aicVM-prop get vbox_graph_mode`
if [ -n "$prop_vbox_graph_mode" ]; then
  vbox_graph_mode="$prop_vbox_graph_mode"
  setprop aicVM.vbox_graph_mode "$prop_vbox_graph_mode"
fi

prop_vbox_dpi=`/system/bin/aicVM-prop get vbox_dpi`
if [ -n "$prop_vbox_dpi" ]; then
  vbox_dpi="$prop_vbox_dpi"
  setprop aicVM.vbox_dpi "$prop_vbox_dpi"
fi

prop_vkeyboard_mode=`/system/bin/aicVM-prop get vkeyboard_mode`
if [ -n "$prop_vkeyboard_mode" ]; then
  vkeyboard_mode="$prop_vkeyboard_mode"
  setprop aicVM.vkeyboard_mode "$prop_vkeyboard_mode"
fi

prop_su_bypass=`/system/bin/aicVM-prop get su_bypass`
if [ $prop_su_bypass ]; then
  setprop aicd.su.bypass 1
fi

# Setting Device Id system properties from VirtualBox properties
prop_device_id=$(/system/bin/aicVM-prop get aic_device_id)
if [ $? -ne 0 ]; then
  # Default value if unset
  setprop aicd.device.id "00000000000000"
else
  # Set user defined value. "[none]" keyword means empty value
  setprop aicd.device.id "$prop_device_id"
fi

# UVESAFB
insmod /system/lib/uvesafb.ko mode_option=$vbox_graph_mode scroll=redraw

setprop ro.sf.lcd_density $vbox_dpi

if [ $prop_hardware_opengl ]; then
    setprop aicVM.gles 1
    prop_hardware_opengl_disable_render=`/system/bin/aicVM-prop get hardware_opengl_disable_render`
    if [ -z "$prop_hardware_opengl_disable_render" -o "$prop_hardware_opengl_disable_render" != "1" ]; then
      setprop aicVM.gles.renderer 1
    fi
fi

# Set Wifi MAC address
setprop wifi.interface.mac `cat /sys/class/net/eth1/address`

setprop aicVM.inited 1

ADB_KEYS=/data/misc/adb/adb_keys
# Legacy API - easier than OpenStack + JSON parsing
[ -f $ADB_KEYS ] || wget http://169.254.169.254/2009-04-04/meta-data/public-keys/0/openssh-key -O $ADB_KEYS 2>/dev/null

) 2>&1 | /system/xbin/tee /dev/tty0 /dev/ttyS0

