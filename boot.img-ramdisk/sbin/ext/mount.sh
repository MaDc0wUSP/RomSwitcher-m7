#!/sbin/busybox sh

ROM=$1

mkdir -p /romswitcher
mkdir -p /.firstrom/media/0/romswitcher-tmp
mount --bind /.firstrom/media/0/romswitcher-tmp /romswitcher

mount -o remount,rw /system
mount -t rootfs -o remount,rw rootfs
mount -t tmpfs tmpfs /system/lib/modules
chmod 755 /system
ln -s /lib/modules/* /system/lib/modules/

if [ "$ROM" == "secondary" ]; then
    mkdir -p /.firstrom/media/.secondrom/data/app
    cp -f /.firstrom/app/com.grarak.*.apk /.firstrom/media/.secondrom/data/app/
    chmod 755 /.firstrom/media/.secondrom/data/app/*.apk

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
    fi
elif [ "$ROM" == "tertiary" ]; then
    mkdir -p /.firstrom/media/.thirdrom/data/app
    cp -f /.firstrom/app/com.grarak.*.apk /.firstrom/media/.thirdrom/data/app/
    chmod 755 /.firstrom/media/.thirdrom/data/app/*.apk
elif [ "$ROM" == "quaternary" ]; then
    mkdir -p /.firstrom/media/.fourthrom/data/app
    cp -f /.firstrom/app/com.grarak.*.apk /.firstrom/media/.fourthrom/data/app/
    chmod 755 /.firstrom/media/.fourthrom/data/app/*.apk
elif [ "$ROM" == "quinary" ]; then
    mkdir -p /.firstrom/media/.fifthrom/data/app
    cp -f /.firstrom/app/com.grarak.*.apk /.firstrom/media/.fifthrom/data/app/
    chmod 755 /.firstrom/media/.fifthrom/data/app/*.apk
fi

mkdir -p /system/etc/init.d
chmod 755 /system/etc/init.d
cp -f /usr/keylayout/synaptics-rmi-touchscreen.kl /system/usr/keylayout/synaptics-rmi-touchscreen.kl
chmod 644 /system/usr/keylayout/synaptics-rmi-touchscreen.kl

if [ -e /system/bin/mpdecision ] ; then
    mv /system/bin/mpdecision /system/bin/mpdecision_bck
fi
