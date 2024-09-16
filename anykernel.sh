# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=sweet
device.name2=sweetin
device.name3=
supported.versions=11 - 14.1
'; } # end properties

boot_attributes() {
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;
} # end attributes

# boot shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Selinux Permissive
#patch_cmdline androidboot.selinux androidboot.selinux=permissive

# migrate from /overlay to /overlay.d to enable SAR Magisk

# end ramdisk changes
# boot install
dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

write_boot; 
## end install

sleep 3
ui_print ""
ui_print "kernel installed successfully"
