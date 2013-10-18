#!/sbin/sh

BB="busybox"
FILESYSTEM=$1

if [ $FILESYSTEM == "secondary" ]; then

   $BB mkdir -p /data/media/.secondrom
   second=/data/media/.secondrom/system.img

   if $BB [ ! -f $second ] ; then
	# create a file 650MB
	$BB dd if=/dev/zero of=$second bs=1024 count=657286 || exit 1
	# create ext4 filesystem
	$BB mke2fs -F -T ext4 $second || exit 1
   fi

elif [ $FILESYSTEM == "tertiary" ]; then

   $BB mkdir -p /data/media/.thirdrom
   third=/data/media/.thirdrom/system.img

   if $BB [ ! -f $third ] ; then
      # create a file 650MB
      $BB dd if=/dev/zero of=$third bs=1024 count=657286 || exit 1
      # create ext4 filesystem
      $BB mke2fs -F -T ext4 $third || exit 1
   fi
elif [ $FILESYSTEM == "quaternary" ]; then

   $BB mkdir -p /data/media/.fourthrom
   fourth=/data/media/.fourthrom/system.img

   if $BB [ ! -f $fourth ] ; then
      # create a file 650MB
      $BB dd if=/dev/zero of=$fourth bs=1024 count=657286 || exit 1
      # create ext4 filesystem
      $BB mke2fs -F -T ext4 $fourth || exit 1
   fi
   elif [ $FILESYSTEM == "quinary" ]; then

   $BB mkdir -p /data/media/.fifthrom
   fifth=/data/media/.fifthrom/system.img

   if $BB [ ! -f $fifth ] ; then
      # create a file 650MB
      $BB dd if=/dev/zero of=$fifth bs=1024 count=657286 || exit 1
      # create ext4 filesystem
      $BB mke2fs -F -T ext4 $fifth || exit 1
   fi

fi

exit 0
