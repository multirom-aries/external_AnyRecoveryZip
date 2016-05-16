	AnyRecovery - Flashable Zip Template for Recovery Releases with recovery.img


	Generate AnyRecovery.zip by sndnvaps `<sndnvaps@gmail.com>`


# Before build

	1 add `TARGET_BUILD_REC_ZIP := true` to BoardConfig.mk
	2 $cd $(TOP_ANDROID_SRC)
	3 Clone the repo `git clone https://github.com/multirom-aries/external_AnyRecoveryZip -b master external/AnyRecovery`

# what Recovery parition support 
	1 support Recovery partition like `/dev/block/platform/msm_sdcc.1/by-name/recovery`
	2. you can make you change by modified (prebuilt_AnyRecoveryZip/META-INF/com/google/android/updater-script) ,fix line 11, to make it match you device (partition of you recovery device)

#  build anyrecovery.zip

```
	$source build/envsetup.sh
	$lunch cm_DEVICENAME-eng #(replace DEVICENAME with you own specise,such as `aries,hammerhead`)
	$make anyrecovery_zip 
	$just have a coffce , anyrecovery.zip is build finish
	$copy $(TARGET_OUT)/anyrecovery.zip to you sdcard or use `adb sideload` to install it
```


# Clean the output file 

	$make anyrecovery_clean	
