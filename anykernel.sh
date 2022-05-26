# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string= 
maintainer.string=Cakeby Kernel by Kakashi
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=tissot
supported.versions=9 - 12
supported.patchlevels=
'; } # end properties


# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel boot install
dump_boot;
# begin ramdisk changes
# Clean up other kernels' ramdisk overlay.d files
rm -rf $ramdisk/overlay.d
# Add our ramdisk files if Magisk is installed
if [ -d $ramdisk/.backup ]; then
	ui_print " "; ui_print "Installing Spectrum..."
	mv /tmp/anykernel/overlay.d $ramdisk/overlay.d
	cp -f /system_root/init.rc $ramdisk/overlay.d
	sleep 2
		insert_line $ramdisk/overlay.d/init.rc "init.spectrum.rc" after 'import /init.usb.rc' "import /init.spectrum.rc"
		ui_print "Spectrum installed succesfully"
    set_perm_recursive 0 0 750 750 $ramdisk/*
fi;


write_boot;
## end boot install

ui_print "Cakeby Kernel OC Installed Succesfully";
