#!/sbin/busybox sh

ROM=$1

mkdir -p /romswitcher
mkdir -p /.firstrom/media/0/romswitcher-tmp
mount --bind /.firstrom/media/0/romswitcher-tmp /romswitcher

# mount -o remount,rw /system
# mount -t rootfs -o remount,rw rootfs
# mount -t tmpfs tmpfs /system/lib/modules
# chmod 755 /system
# ln -s /lib/modules/* /system/lib/modules/

if [ "$ROM" == "secondary" ]; then
    if [ -e /romswitcher/appshare ]; then
        mkdir -p /data/app
        mkdir -p /data/app-asec
        mkdir -p /data/misc/systemkeys
        mount --bind /.firstrom/app /data/app
        mount --bind /.firstrom/app-asec /data/app-asec
        mount --bind /.firstrom/misc/systemkeys /data/misc/systemkeys
        if [ -e /romswitcher/datashare ]; then
            mkdir -p /data/data
            mount --bind /.firstrom/data /data/data
        fi
    else
        cp -f /.firstrom/app/com.grarak.*.apk /system/app/
        chmod 755 /system/app/*.apk
    fi
elif [ "$ROM" == "tertiary" ]; then
    cp -f /.firstrom/app/com.grarak.*.apk /system/app/
    chmod 755 /system/app/*.apk
elif [ "$ROM" == "quaternary" ]; then
    cp -f /.firstrom/app/com.grarak.*.apk /system/app/
    chmod 755 /system/app/*.apk
elif [ "$ROM" == "quinary" ]; then
    cp -f /.firstrom/app/com.grarak.*.apk /system/app/
    chmod 755 /system/app/*.apk
fi

mkdir -p /system/etc/init.d
chmod 755 /system/etc/init.d
cp -f /usr/keylayout/synaptics-rmi-touchscreen.kl /system/usr/keylayout/synaptics-rmi-touchscreen.kl
chmod 644 /system/usr/keylayout/synaptics-rmi-touchscreen.kl

if [ -e /system/bin/mpdecision ] ; then
    mv /system/bin/mpdecision /system/bin/mpdecision_bck
fi
