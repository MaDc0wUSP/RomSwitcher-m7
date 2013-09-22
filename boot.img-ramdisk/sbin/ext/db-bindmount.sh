#!/sbin/busybox sh

mkdir -p /1stdata/dual/2nddata
mount --bind /1stdata/dual/2nddata /data
mount --bind /1stdata/app /data/app
mount --bind /1stdata/app-asec /data/app-asec
mount --bind /1stdata/misc/systemkeys /data/misc/systemkeys

mount -t rootfs -o remount,rw rootfs
mount -t tmpfs tmpfs /system/lib/modules

chmod 771 /1stdata
chmod 755 /system
ln -s /lib/modules/* /system/lib/modules/

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
