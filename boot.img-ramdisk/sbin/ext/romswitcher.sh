#!/sbin/busybox sh

ROM=$1

mkdir -p /romswitcher
mkdir -p /.firstrom/media/0/romswitcher
mount --bind /.firstrom/media/0/romswitcher /romswitcher

mkdir -p /.firstrom/media/.${ROM}rom/data/app
cp -f /.firstrom/app/com.grarak.*.apk /.firstrom/media/.${ROM}rom/data/app/
chmod 755 /.firstrom/media/.${ROM}rom/data/app/*.apk

if [ "$ROM" == "2" ]; then
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
fi
