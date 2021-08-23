# Copyright (C) 2016 The Android Open Source Project
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

LOCAL_PATH := device/sprd/sharkle/common
ROOTCOMM := $(LOCAL_PATH)/rootdir
include $(LOCAL_PATH)/ModemCommon.mk
#ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)
include $(LOCAL_PATH)/TelephonyCommon.mk
#endif
include $(wildcard $(LOCAL_PATH)/common_packages.mk)
include $(LOCAL_PATH)/emmc/emmc_device.mk

OMA_DRM := false

# add oma drm in pac
#PRODUCT_PACKAGES += \
    libdrmomaplugin
#for fota
PRODUCT_PACKAGES += updater

PRODUCT_PACKAGES += AppClone

ifeq ($(OMA_DRM),true)
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true
else
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=false
endif

ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)
PRODUCT_PACKAGES += \
    SGPS

PRODUCT_PACKAGES += \
    gnss_download	\
    libnfctest \
    autotest \
    libgpio \

#default audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

#audio hidl hal impl
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.audio@2.0-service

# Sensor HAL
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl

# Power hidl HAL
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service \
    vendor.sprd.hardware.power@1.0-impl \
    vendor.sprd.hardware.power@1.0-service

# Light HAL
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service

# Keymaster HAL
#PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Bluetooth HAL
#PRODUCT_PACKAGES += \
#    libbt-vendor \
#    android.hardware.bluetooth@1.0-impl

# add  treble enable
PRODUCT_PROPERTY_OVERRIDES += \
ro.treble.enabled = true

# ro.product.first_api_level indicates the first api level the device has commercially launched on.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=26

# add vndk version
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.vndk.version = 1

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.sprd.wcnreset=1 \
    persist.sys.apr.enabled=0 \
    persist.sys.start_udpdatastall=0
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.sprd.wcnreset=0 \
    persist.sys.apr.enabled=1 \
    persist.sys.start_udpdatastall=1
endif # TARGET_BUILD_VARIANT == user

#poweroff charge
PRODUCT_PACKAGES += charge \
                    phasecheckserver
#PowerHint HAL
# sprdemand, interactive
BOARD_POWERHINT_HAL := interactive
# POWERHINT_PRODUCT_CONFIG := sharkle

# Power hint config file
PRODUCT_PACKAGES += \
    power_scene_id_define.txt \
    power_scene_config.xml \
    power_resource_file_info.xml

# ION HAL module
PRODUCT_PACKAGES += \
    libmemion
# ION module
PRODUCT_PACKAGES += \
    libion

# Camera configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
camera.disable_zsl_mode=1

# media component modules
PRODUCT_PACKAGES += \
    libsprd_omx_core                     \
    libstagefrighthw                     \
    libstagefright_sprd_h264dec          \
    libstagefright_sprd_h264enc          \
    libstagefright_sprd_mpeg4dec         \
    libstagefright_sprd_mp3dec           \
    libstagefright_soft_imaadpcmdec      \
    libstagefright_soft_mjpgdec          \
    libstagefright_sprd_mp3enc

# factorytest modules
PRODUCT_PACKAGES += \
	factorytest

# sensor
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-service \
    android.hardware.vibrator@1.0-impl

# gnss
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl \
    gps.default \
    liblte 


#PRODUCT_PACKAGES += \
	sensors.firmware	\
	libsensorsdrvcfg	\
	libsensorlistcfg	\

endif #BUILD_SPRD_CUSTOM_ANDROID

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/init.common.rc:root/init.common.rc \
    $(LOCAL_PATH)/rootdir/root/init.ram.rc:root/init.ram.rc \
    $(BOARDDIR)/recovery/init.recovery.$(TARGET_BOARD).rc:root/init.recovery.$(TARGET_BOARD).rc \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/adaptive_ts.kl:system/usr/keylayout/adaptive_ts.kl \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    $(LOCAL_PATH)/rootdir/system/usr/idc/adaptive_ts.idc:system/usr/idc/adaptive_ts.idc \
    $(LOCAL_PATH)/rootdir/system/media/engtest_sample.pcm:system/media/engtest_sample.pcm \
    $(LOCAL_PATH)/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml
#    $(LOCAL_PATH)/rootdir/system/vendor/firmware/D5523E6G_5x46__V08_D01_20160226_app.bin:system/vendor/firmware/focaltech-FT5x46.bin \

# graphics modules
PRODUCT_PACKAGES += mali.ko  gralloc.$(TARGET_BOARD_PLATFORM).so

ifeq ($(strip $(GRAPHIC_RENDER_TYPE)), CPU)
PRODUCT_PACKAGES +=  \
        libGLES_android \
        libEGL       \
        libGLESv1_CM \
        libGLESv2
ifeq ($(strip $(USE_SPRD_HWCOMPOSER)),true)
$(error, USE_SPRD_HWCOMPOSER should not be true)
endif

else # $(GRAPHIC_RENDER_TYPE)), CPU)
PRODUCT_PACKAGES += \
    libGLES_mali.so

PRODUCT_PACKAGES += \
    camera.device@1.0-impl \
    camera.device@3.2-impl \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service

ifeq ($(strip $(USE_SPRD_HWCOMPOSER)),true)
$(warning, if sprd hwcomposer is not ready, USE_SPRD_HWCOMPOSER should not be true)
PRODUCT_PACKAGES +=  hwcomposer.$(TARGET_BOARD_PLATFORM)
endif

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
   ro.gpu.boost=0

ifeq ($(strip $(TARGET_GPU_PLATFORM)),midgard)

else
PRODUCT_COPY_FILES += \
    vendor/sprd/external/drivers/gpu/utgard/mali/mali.ko:root/lib/modules/mali.ko
endif

endif # $(GRAPHIC_RENDER_TYPE)), CPU)

#End Graphic Module

# multimedia configs
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    $(LOCAL_PATH)/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/numeric_operator.xml:system/etc/numeric_operator.xml \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
# for bootanimation
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

#wifi UI configs
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

#copy cdrom resource file
PRODUCT_COPY_FILES += \
    vendor/sprd/resource/cdrom/adb.iso:system/etc/adb.iso

# Power Framework
#PRODUCT_COPY_FILES += \
    vendor/sprd/platform/frameworks/native/data/etc/power_info.db:system/etc/power_info.db \
    vendor/sprd/platform/frameworks/native/data/etc/appPowerSaveConfig.xml:system/etc/appPowerSaveConfig.xml \
    vendor/sprd/platform/frameworks/native/data/etc/blackAppList.xml:system/etc/blackAppList.xml \
    vendor/sprd/platform/frameworks/native/data/etc/pwctl_config.xml:system/etc/pwctl_config.xml \
    vendor/sprd/platform/frameworks/native/data/etc/powercontroller.xml:system/etc/powercontroller.xml

#copy cgroup blkio resource file
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/cgroup_blkio.rc:system/etc/init/cgroup_blkio.rc
endif

ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)

# SPRD WCN modules
PRODUCT_PACKAGES += connmgr

PRODUCT_PACKAGES += \
    FileExplorer \
    FileExplorerDRMAddon

# Launcher
PRODUCT_PACKAGES += \
    Launcher3 \
    WallpaperPicker

# MultiMedia Apps
#PRODUCT_PACKAGES += \
    SprdFMRadio \
    DreamFMRadio

# Network related modules
PRODUCT_PACKAGES += \
    dhcp6c \
    dhcp6s \
    radvd \
    tcpdump \
    ext_data \
    tiny_firewall.sh \
    data_rps.sh \
    netbox.sh

PRODUCT_PACKAGES += \
    bluetooth.default \
    audio.a2dp.default

#copy thermal config file
ifeq ($(TARGET_BOARD),sp9820e_2c10)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal_2c10.conf:system/etc/thermal.conf
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal.conf:system/etc/thermal.conf
endif

# APR auto upload
PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.apr.intervaltime=1 \
	persist.sys.apr.testgroup=CSSLAB \
	persist.sys.apr.autoupload=1


PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.heartbeat.enable=1\
    persist.sys.power.touch=1

endif #ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)

# PDK prebuild apps
#include $(wildcard vendor/sprd/pdk_prebuilts/prebuilts.mk)

# add widevine build for androidn
#PRODUCT_PACKAGES += \
    libwvdrmengine

ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)
# add sprd Contacts
#PRODUCT_PACKAGES += \
#    SprdContacts \
#    SprdContactsProvider \
#    ContactsBlackListAddon \
#    ContactsDefaultContactAddon \
#    ContactsEFDisplayAddon \
#    EFDisplaySupportAddon \
#    FastScrollBarSupportAddon

# add sprd browser
PRODUCT_PACKAGES += \
    SprdBrowser \
    SprdBrowserCustomAddon \
    SprdBrowserStorageAddon

# add drm for sprd browser
#PRODUCT_PACKAGES += \
    BrowserXposed

# add oma drm for download&documentui
#PRODUCT_PACKAGES += \
    DownloadProviderDrmAddon \
    DocumentsUIXposed

#udpDataStall
PRODUCT_PACKAGES += \
        UdpDataStallService \
        dsd

#dataLogDaemon
PRODUCT_PACKAGES += \
        dataLogDaemon

# add sprd email
PRODUCT_PACKAGES += \
    Email2 \
    Exchange2

# add sprd calendar
PRODUCT_PACKAGES += \
    SprdCalendar

# add sprd CalendarProvider
PRODUCT_PACKAGES += \
    SprdCalendarProvider

# add sprd quicksearchbox
PRODUCT_PACKAGES += \
    SprdQuickSearchBox

# add sprd deskclock
PRODUCT_PACKAGES += \
    SprdDeskClock

# SPRD: FEATURE_VOLTE_CALLFORWARD_OPTIONS
#PRODUCT_PACKAGES += \
    CallSettings \
    CallFireWall
# misc
PRODUCT_PACKAGES += tune2fs

# add zram
PRODUCT_PACKAGES += \
    zram.sh

ifeq (true,$(strip $(TARGET_DM_VERITY)))
$(call inherit-product, build/target/product/verity.mk)
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/system
endif

$(call inherit-product, mozilla-b2g/gonk-misc/b2g.mk)

endif # BUILD_SPRD_CUSTOM_ANDROID

ifneq ($(strip $(wildcard vendor/sprd/modules/radiointeractor/Android.mk)),)
    PRODUCT_PACKAGES += radio_interactor_service
    PRODUCT_PACKAGES += radio_interactor_common
endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=cdrom

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    sys.usb.controller=musb-hdrc.0.auto

#SPRD: Bug#474442 Add for Wifi Auto Roam Feature BEG-->
# Set default disable auto roam
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.support.auto.roam=disabled
#<-- Add for Wifi Auto Roam Feature END

ifeq ($(BUILD_SPRD_CUSTOM_ANDROID),)
PRODUCT_PACKAGES += lmfs
endif

PRODUCT_REVISION += multiuser

# For gator by Ken.Kuang
#PRODUCT_PACKAGES += gatord \
		    gator.ko
#PRODUCT_COPY_FILES += vendor/sprd/tools/gator/gatordstart:$(TARGET_COPY_OUT_VENDOR)/bin/gatordstart

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest.xml:system/manifest.xml

#add for sprd recents
PRODUCT_PROPERTY_OVERRIDES += persist.recents.sprd=1

#use timerfd mode to adapt sharkle alarm
PRODUCT_PROPERTY_OVERRIDES += ro.kaios.use_timerfd=true

#add USB related node
PRODUCT_PROPERTY_OVERRIDES += \
       ro.kaios.usb.functions_node=/config/usb_gadget/g1/configs/b.1/strings/0x409/configuration \
       ro.kaios.ums.directory_node=/config/usb_gadget/g1/functions/mass_storage.gs6 \
       ro.kaios.mtp.directory_node=/config/usb_gadget/g1/functions/mtp.gs0 \
       ro.kaios.usb.state_node=/sys/class/android_usb/android0/state

$(warning  "common/DeviceCommon.mk: PRODUCT_PACKAGES:  $(PRODUCT_PACKAGES)")
