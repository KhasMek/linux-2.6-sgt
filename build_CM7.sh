#!/bin/bash

DATE=$(date +%m%d)
CONFIG="galaxytab_CM7"
rm update/kernel_update.zip
rm update/kernel_update/zImage
#rm ../KERNEL_BACKUPS/"$DATE"_"$CONFIG"_OC.tar
rm "$DATE"_stdlog_"$CONFIG"_OC.log
rm "$DATE"_errlog_"$CONFIG"_OC.log
rm ../KhasMek.Voodoo.Plus.CDMA.Tab."$DATE".CM7.OC.zip
rm ../KhasMek_"$DATE"_CM7_CM7_zImage
#rm ../../../Dropbox/Kernels_etc/Tab/KhasMek.Voodoo.Plus.CDMA.Tab."$DATE".CM7.OC.zip

make mrproper
make clean
make ARCH=arm khasmek_"$CONFIG"_defconfig
make -j2 CROSS_COMPILE=../../../arm-2009q3/bin/arm-none-linux-gnueabi- \
	ARCH=arm HOSTCFLAGS="-g -O3" 1> "$DATE"_stdlog_"$CONFIG"_OC.log 2> "$DATE"_errlog_"$CONFIG"_OC.log 


cp arch/arm/boot/zImage ../KhasMek_"$DATE"_CM7_CM7_zImage
cp arch/arm/boot/zImage update/kernel_update/zImage
cd update
zip -r kernel_update.zip . 
java -classpath ../../../../android-sdk-linux_x86/tools/sign/testsign.jar testsign kernel_update.zip ../KhasMek.Voodoo.Plus.CDMA.Tab."$DATE".CM7.OC.zip
#cp ../../KERNEL_BACKUPS/KhasMek.Voodoo.Plus.CM7.Tab."$DATE".CM7.OC.zip ../../../../Dropbox/Kernels_etc/Tab/KhasMek.Voodoo.Plus.CDMA.Tab."$DATE".CM7.OC.zip

cd kernel_update
tar --format=ustar -cf kernel_update.tar zImage
mv kernel_update.tar ../"$DATE"_"$CONFIG"_OC.tar
cd ../..


