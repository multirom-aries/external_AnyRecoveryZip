# Copyright (C) 2016 JimesYang <sndnvaps@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)
ifeq ($(TARGET_BUILD_REC_ZIP),true)

ANYRECOVERY_ZIP_TARGET := $(PRODUCT_OUT)/anyrecovery

include $(CLEAR_VARS)

ar_recovery_zip_path := $(LOCAL_PATH)/prebuilt_AnyRecoveryZip


ar_recovery_image := $(PRODUCT_OUT)/recovery.img

ANYRECOVERY_INS_DIR := $(PRODUCT_OUT)/anykernel_installer



$(ANYRECOVERY_ZIP_TARGET): signapk recoveryimage
	@echo
	@echo
	@echo "    * Build AnyRecoveryZip.zip for" $(TARGET_DEVICE)
	@echo "    * Create anyrecovery.zip by sndnvaps"
	@echo "Thank you. See DONORS.md in  folder for more informations."
	@echo
	@echo

	@echo ----- Making AnyRecovery ZIP installer ------
	rm -rf $(ANYRECOVERY_INS_DIR)
	mkdir -p $(ANYRECOVERY_INS_DIR)

	cp -a $(ar_recovery_zip_path)/* $(ANYRECOVERY_INS_DIR)/
	cp -a $(ar_recovery_image) $(ANYRECOVERY_INS_DIR)/
	rm -f $(ANYRECOVERY_ZIP_TARGET).zip $(ANYRECOVERY_ZIP_TARGET)-unsigned.zip
	cd $(ANYRECOVERY_INS_DIR) && zip -qr ../$(notdir $@)-unsigned.zip *
	java -jar $(HOST_OUT_JAVA_LIBRARIES)/signapk.jar $(DEFAULT_SYSTEM_DEV_CERTIFICATE).x509.pem $(DEFAULT_SYSTEM_DEV_CERTIFICATE).pk8 $(ANYRECOVERY_ZIP_TARGET)-unsigned.zip $(ANYRECOVERY_ZIP_TARGET).zip
	$(ar_recovery_zip_path)/../rename_zip.sh $(ANYRECOVERY_ZIP_TARGET) $(TARGET_DEVICE) $(ar_recovery_zip_path)/../version.h
	@echo ----- Made AnyRecovery ZIP installer -------- $@.zip

.PHONY: anyrecovery_zip
anyrecovery_zip: $(ANYRECOVERY_ZIP_TARGET)


include $(CLEAR_VARS)

ANYRECOVERY_ZIP_CLEAN:
	@echo
	@echo
	@echo "Clean all the AnyRecovery.zip file !!!"
	@echo "Start clean "
	@echo "this file write by sndnvaps<sndnvaps@gmail.com>"
	@echo
	@echo

	@echo ----------------- Clean AnyRecovery Zip Files ----------
	rm -rf $(ANYRECOVERY_INS_DIR)
	rm -rf $(ANYRECOVERY_ZIP_TARGET).zip 
	rm -rf $(ANYRECOVERY_ZIP_TARGET)-unsigned.zip
	rm -rf $(ANYRECOVERY_ZIP_TARGET)*.zip
	rm -rf $(ANYRECOVERY_ZIP_TARGET)*.md5sum
	@echo --------Finish clean AnyRecovery Zip Files --------------

.PHONY: anyrecovery_clean
anyrecovery_clean: ANYRECOVERY_ZIP_CLEAN

endif
