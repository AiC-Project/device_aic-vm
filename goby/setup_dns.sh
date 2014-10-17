#!/system/bin/sh
# We need to wait until netd starts
while getprop dev.bootcomplete |grep -v 1 > /dev/null ; do sleep 1; done


DEFAULT_DNS1=$(getprop net.dns1)
DEFAULT_DNS2=$(getprop net.dns2)

i=0
DNS1=$(getprop net.eth$i.dns1)
DNS2=$(getprop net.eth$i.dns2)
[ -z "$DNS1" ] && DNS1=$DEFAULT_DNS1
[ -z "$DNS2" ] && DNS2=$DEFAULT_DNS2
/system/bin/ndc resolver setifdns eth$i $DNS1 $DNS2
/system/bin/ndc resolver setdefaultif eth$i


i=1
if [ -e /sys/class/net/eth$i ]
then
    DNS1=$(getprop net.eth$i.dns1)
    DNS2=$(getprop net.eth$i.dns2)
    [ -z "$DNS1" ] && DNS1=$DEFAULT_DNS1
    [ -z "$DNS2" ] && DNS2=$DEFAULT_DNS2
    /system/bin/ndc resolver setifdns eth$i $DNS1 $DNS2
    /system/bin/ndc resolver setdefaultif eth$i
fi

i=2
if [ -e /sys/class/net/eth$i ]
then
    DNS1=$(getprop net.eth$i.dns1)
    DNS2=$(getprop net.eth$i.dns2)
    [ -z "$DNS1" ] && DNS1=$DEFAULT_DNS1
    [ -z "$DNS2" ] && DNS2=$DEFAULT_DNS2
    /system/bin/ndc resolver setifdns eth$i $DNS1 $DNS2
    /system/bin/ndc resolver setdefaultif eth$i
fi
