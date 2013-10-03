#!/sbin/busybox sh

mkdir -p /.firstrom/media/.secondrom/data
mount --bind /.firstrom/media/.secondrom/data /data
mkdir -p /romswitcher
mkdir -p /.firstrom/media/0/romswitcher-tmp
mount --bind /.firstrom/media/0/romswitcher-tmp /romswitcher

mount -t rootfs -o remount,rw rootfs
mount -t tmpfs tmpfs /system/lib/modules

chmod 755 /system
ln -s /lib/modules/* /system/lib/modules/

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

mount -t rootfs -o remount,ro rootfs

# n3ocort3x's teaMseven kernel compatibility
if uname -r | grep "teaMseven" > /dev/null ; then
	mkdir -p /system/etc/init.d
	chmod 755 /system/etc/init.d
	cp -f /usr/keylayout/synaptics-rmi-touchscreen.kl /system/usr/keylayout/synaptics-rmi-touchscreen.kl
	chmod 644 /system/usr/keylayout/synaptics-rmi-touchscreen.kl

	if [ -e /system/bin/mpdecision ] ; then
		mv /system/bin/mpdecision /system/bin/mpdecision_bck
	fi

elif uname -r | grep "CM" > /dev/null ; then
	if [ -e /system/bin/mpdecision_bck ] ; then
		mv /system/bin/mpdecision_bck /system/bin/mpdecision
	fi
fi
