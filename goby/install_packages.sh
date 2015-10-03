#!/system/bin/sh
# This script installs packages present on the sdcard and removes the source afterwards

# wait, this service has been spawned while installd was just booting

while getprop dev.bootcomplete |grep -v 1 > /dev/null ; do sleep 1; done

SDCARD="/mnt/sdcard/apk/"
[ -d $SDCARD ] && \
{
    for filename in `ls $SDCARD`;
    do
        pm install -r "$SDCARD$filename" 2>&1 | grep Fail > /dev/null && return 1 || rm "$SDCARD$filename"
    done
} && rmdir $SDCARD


