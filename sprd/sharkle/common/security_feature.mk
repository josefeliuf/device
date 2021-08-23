#
# three config options can be set in one specific android board as follows:
# BOARD_TEE_CONFIG := trusty
# BOARD_FINGERPRINT_CONFIG := vendor(chipone)
# BOARD_SECBOOT_CONFIG := true
# after setting these options, include this file as include "device/sprd/sharkle/common/security_feature.mk"
#
# sml and firewall is not related to tos, so config them outside the BOARD_TEE_CONFIG
#

BOARD_ATF_CONFIG := true
TARGET_NO_SML_13 := false
#TARGET_SML_CONFIG := <board>[@<platform>@arch]
TARGET_SML_CONFIG := sharkle@sharkle

#feature phone
ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
BOARD_SEC_MEM_SIZE := 0x20000
BOARD_SML_MEM_SIZE := 0x20000
BOARD_SML_MEM_ADDR := 0x8e000000
#smart phone
else
BOARD_SEC_MEM_SIZE := 0x100000
BOARD_SML_MEM_SIZE := 0x100000
BOARD_SML_MEM_ADDR := 0x94000000
endif

CONFIG_TEE_FIREWALL := true

ifeq ($(strip $(BOARD_TEE_CONFIG)), trusty)

TRUSTY_PRODUCTION := true
BOARD_ATF_BOOT_TOS_CONFIG := true

#trusty related config

ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
ifeq ($(strip $(BOARD_KAIOS_CONFIG)), true)
CFG_TRUSTY_DEFAULT_PROJECT := sharkle-kaios
else
CFG_TRUSTY_DEFAULT_PROJECT := sharkle-feature
endif
else
CFG_TRUSTY_DEFAULT_PROJECT := sharkle
BOARD_TEE_64BIT := true
endif

#Add for android 8.0 gatekeeper HDIL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl

PRODUCT_PACKAGES += \
    gatekeeper.default \
    libtrusty \
    sprdstorageproxyd \
    rpmbserver \
    libteeproduction

ifeq ($(strip $(BOARD_FEATUREPHONE_CONFIG)),)
PRODUCT_PACKAGES += \
    keystore.sprdtrusty \
#    ApplicationLock \

endif

TRUSTY_SEPOLICY_DIR :=vendor/sprd/proprietories-source/sprdtrusty/vendor/sprd/modules/common/sepolicy
BOARD_SEPOLICY_DIRS += $(TRUSTY_SEPOLICY_DIR)


#secure boot
ifeq ($(strip $(BOARD_SECBOOT_CONFIG)), true)
SECURE_BOOT_LABEL_FILE := $(OUT_DIR)/PRODUCT_SECURE_BOOT_SPRD
SECURE_BOOT_KCE := DISABLE
#SANSA|SPRD|NONE
PRODUCT_SECURE_BOOT := SPRD
PRODUCT_PACKAGES += sprd_sign

#for modem signing in pac script
#$(info $(shell touch $(OUT_DIR)/PRODUCT_SECURE_BOOT_SPRD))
$(warning "$(shell touch $(SECURE_BOOT_LABEL_FILE)) PRODUCT_SECURE_BOOT_SPRD created")
endif

#feature phone
ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
#for kaios feature phone
ifeq ($(strip $(BOARD_KAIOS_CONFIG)), true)
BOARD_SEC_MEM_SIZE := 0x600000
BOARD_TOS_MEM_SIZE := 0x5e0000
BOARD_TOS_MEM_ADDR := 0x8e020000
else
BOARD_SEC_MEM_SIZE := 0x200000
BOARD_TOS_MEM_SIZE := 0x1e0000
BOARD_TOS_MEM_ADDR := 0x8e020000
endif
#smart phone
else
#fingerprint
ifneq ($(BOARD_FINGERPRINT_CONFIG),)
PRODUCT_PACKAGES += fingerprintd

# enable Fingerprint feature
PRODUCT_PROPERTY_OVERRIDES += \
    persist.support.fingerprint=true \
    persist.sprd.fp.lockapp=true \
    persist.sprd.fp.launchapp=true

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml

BOARD_SEC_MEM_SIZE := 0x1000000
BOARD_TOS_MEM_SIZE := 0xf00000
BOARD_TOS_MEM_ADDR := 0x94100000
else
BOARD_SEC_MEM_SIZE := 0x1000000
BOARD_TOS_MEM_SIZE := 0xf00000
BOARD_TOS_MEM_ADDR := 0x94100000
endif
endif

#add dynamic lib to read uid
HAS_GETUID_LIB := true
PRODUCT_PACKAGES += libgetuid

ifeq ($(strip $(BOARD_FINGERPRINT_CONFIG)), chipone)
PRODUCT_PACKAGES += fpExtensionService
include vendor/sprd/partner/chipone/chipone.mk
endif

endif
