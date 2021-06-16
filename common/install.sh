#!/system/bin/sh
if [ -e /data/adb/magisk/busybox ]; then
 b=/data/adb/magisk/busybox
fi;
$b unzip -oq "$ZIPFILE" 'com.nfs.nfsmanager.apk' -d /data/local/tmp 2>/dev/null
NFSVARS() {
if [ -d /system/bin ]; then
 BIN=$MODPATH/system/bin
elif [ -d /system/xbin ]; then
 BIN=$MODPATH/system/xbin
fi;
UID=$(cat /dev/urandom | $b tr -cd 'a-f0-9' | $b head -c 8) 2>/dev/null
UID1=$(cat /dev/urandom | $b tr -cd 'a-f0-9' | $b head -c 8) 2>/dev/null
UID2=$(cat /dev/urandom | $b tr -cd 'a-f0-9' | $b head -c 8) 2>/dev/null
UID3=$(cat /dev/urandom | $b tr -cd 'a-f0-9' | $b head -c 8) 2>/dev/null
INJECTOR=$MODPATH/system/etc/$UID
TMP=/data/local/tmp
APK=$TMP/com.nfs.nfsmanager.apk
ARCH=$(grep_prop ro.product.cpu.abi | grep "arm" | $b cut -c -5)
API=$(grep_prop ro.build.version.sdk) 2>/dev/null
API1=$(grep_prop ro.vendor.build.version.sdk) 2>/dev/null
API2=$(grep_prop ro.vndk.version) 2>/dev/null
if [ ! "$API" == "" ]; then
 SDK=$(grep_prop ro.build.version.sdk) 2>/dev/null
elif [ ! "$API1" == "" ]; then
 SDK=$(grep_prop ro.vendor.build.version.sdk) 2>/dev/null
elif [ ! "$API2" == "" ]; then
 SDK=$(grep_prop ro.vndk.version) 2>/dev/null
fi;
}
NFSPRINT() {
ui_print "___  | / /__  ____/_  ___/"
ui_print "__   |/ /__  /_   _____ "
ui_print "_  /|  / _  __/   ____/ /"
ui_print "/_/ |_/  /_/      /____/"           
ui_print ""
ui_print "* ϟ NFS-INJECTOR ϟ *"
ui_print ""
ui_print "* KING OF MODS *"
ui_print ""
ui_print "* Module For Forcefulness & Energy Aware *"
ui_print ""
ui_print "* Flash , Reboot And Forget *"
ui_print ""
ui_print "* Official Telegram Group @nfsinjector *"
ui_print "" 
ui_print "* By K1KS & Team *"
ui_print ""
ui_print "* By Randywahidin & magisk Template
ui_print ""
ui_print "* Unique ID : $UID *"
ui_print ""
}
NFSIN() {
if [ -e $MODPATH/injector.tar.xz ]; then
 $b tar -xf $MODPATH/injector.tar.xz -C $MODPATH 2>/dev/null
 rm -f $MODPATH/injector.tar.xz 2>/dev/null
fi;
ui_print "Copying Files..."
if [ -e $MODPATH/service.sh ]; then
 $b sed -i "1i UID=$(eval $b echo \$UID)" $MODPATH/service.sh
 $b sed -i "2i UID1=$(eval $b echo \$UID1)" $MODPATH/service.sh
 $b sed -i "3i UID2=$(eval $b echo \$UID2)" $MODPATH/service.sh
 $b sed -i "4i UID3=$(eval $b echo \$UID3)" $MODPATH/service.sh
fi;
mkdir -p $INJECTOR
mv -f $MODPATH/injector/injector1 $INJECTOR/$UID1
mv -f $MODPATH/injector/injector2 $INJECTOR/$UID2
mv -f $MODPATH/injector/injector3 $INJECTOR/$UID3
mkdir -p $BIN
mv -f $MODPATH/injector/injector $BIN
sleep 2
if [ -e $INJECTOR/$UID1 ] && [ -e $INJECTOR/$UID2 ] && [ -e $INJECTOR/$UID3 ] && [ -e $BIN/injector ]; then
 ui_print "Done."
 ui_print ""
else
 ui_print "Copying Files Failed, Report In Group Support"
 abort "Aborting..."
fi;
}
NFSAPP() {
ui_print "- API/SDK Supported"
sleep 1
if [ -d /storage/emulated/0/NFSManager ] || [ -d /sdcard/NFSManager ] && [ "$(pm list packages -3|$b sed 's/package://g'|$b sort|grep com.nfs.nfsmanager)" == "com.nfs.nfsmanager" ]; then
 ui_print "NFS Manager Already Installed"
 ui_print ""
else
 for i in $APK; do
  if [ -e $APK ]; then
   ui_print "Installing NFS Manager..."
   pm install -r $i
   if [ "$(pm list packages -3|$b sed 's/package://g'|$b sort|grep com.nfs.nfsmanager)" == "com.nfs.nfsmanager" ]; then
    ui_print "NFS Manager Installed"
    ui_print ""
   else
    ui_print "NFS Manager Installation Failed"
    abort "Aborting..."
   fi;
  else
   ui_print "NFS Manager Is Missing!!!"
   ui_print ""
  fi;
 done
fi;
}
NFSVARS
case "$ARCH" in
 "arm64"|"armea")
  NFSPRINT
  NFSIN
  sleep 1
  ui_print "Checking NFS Manager Requirement..."
  sleep 2
  case "$SDK" in
   [0-9]|1[0-9]|2[0-2])
    ui_print "- NFS Manager Required At Least API/SDK 23"
    ui_print ""
   ;;
   *)
    NFSAPP
   ;;
  esac
 ;;
 *)
  ui_print "$(grep_prop ro.product.cpu.abi) Not Supported"
  abort "Aborting..."
 ;;
esac
ARCH=$(grep_prop ro.product.cpu.abi | grep "arm")
rm -f $APK
rm -f $MODPATH/com.nfs.nfsmanager.apk
rm -rf $MODPATH/injector
rm -f $MODPATH/injector.png
