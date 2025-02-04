#TARGET_ARCH := arm64
#TARGET_ARCH_VARIANT := armv8-a
#TARGET_CPU_ABI := arm64-v8a
#TARGET_CPU_VARIANT := generic

#TARGET_2ND_ARCH := arm
#TARGET_2ND_ARCH_VARIANT := armv7-a-neon
#TARGET_2ND_CPU_VARIANT := cortex-a15
#TARGET_2ND_CPU_ABI := armeabi-v7a
#TARGET_2ND_CPU_ABI2 := armeabi

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
#CONFIG_64KERNEL_32FRAMEWORK := true

TARGET_KERNEL_ARCH = arm
TARGET_USES_64_BIT_BINDER := false

LOCAL_PATH := device/sprd/sharkle/common
TARGET_CPU_SMP := true
TARGET_NO_KERNEL := false
ROOTCOMM := $(LOCAL_PATH)/rootdir
PLATCOMM := $(LOCAL_PATH)

BOARD_SUPPORT_UMS_K44 := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_KERNEL_SEPARATED_DT := true
USES_UNCOMPRESSED_KERNEL := true
BOARD_KERNEL_BASE :=  0x00000000
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x05400000
BOARD_KERNEL_PAGESIZE := 2048

#TARGET_GLOBAL_CFLAGS   += -mfpu=neon -mfloat-abi=softfp
#TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

KERNEL_DEFCONFIG := sprd_sharkle_fp_defconfig
ifeq ($(TARGET_KERNEL_ARCH), arm64)
KERNEL_CROSS_COMPILE = $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
endif
ifeq ($(TARGET_KERNEL_ARCH), arm)
KERNEL_CROSS_COMPILE = $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-
endif

# graphics
USE_SPRD_HWCOMPOSER  := true
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
SPRD_VIRTUAL_DISPLAY:= 1

# audio configs
BOARD_USES_GENERIC_AUDIO := true
BOARD_USES_TINYALSA_AUDIO := true
BOARD_USES_ALSA_AUDIO := false
BUILD_WITH_ALSA_UTILS := false
USE_LEGACY_AUDIO_POLICY := 0
USE_CUSTOM_AUDIO_POLICY := 1
SPRD_VBC_NOT_USE_AD23 := true
#SPRD: vbc support deepbufer mixer channel
SPRD_VBC_DEEPBUFFER_MIXER :=true
SPRD_AUDIO_VOIP_VERSION  :=v2


# telephony
BOARD_SPRD_RIL := true
USE_BOOT_AT_DIAG :=true

# ota releasetools extensions
# TARGET_RECOVERY_UPDATER_LIBS := libsprd_updater

TARGET_OTA_EXTENSIONS_DIR := vendor/sprd/tools/ota
TARGET_RELEASETOOLS_EXTENSIONS := $(TARGET_OTA_EXTENSIONS_DIR)
#TARGET_RECOVERY_UI_LIB := librecovery_ui_whale2
# recovery configs
ifneq ($(TARGET_USERIMAGES_USE_UBIFS), true)
RECOVERYCOMM := $(PLATCOMM)/recovery
TARGET_RECOVERY_FSTAB := $(RECOVERYCOMM)/recovery.fstab
TARGET_RECOVERY_INITRC := $(RECOVERYCOMM)/init.rc
endif
ifeq (f2fs,$(strip $(BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE)))
  RECOVERY_FSTAB_SUFFIX1 := .f2fs
endif
ifeq (true,$(strip $(BOARD_SECURE_BOOT_ENABLE)))
  RECOVERY_FSTAB_SUFFIX2 := .secure_boot
endif
ifeq (true,$(strip $(TARGET_DM_VERITY)))
  RECOVERY_FSTAB_SUFFIX3 :=
endif
RECOVERY_FSTAB_SUFFIX := $(RECOVERY_FSTAB_SUFFIX1)$(RECOVERY_FSTAB_SUFFIX2)$(RECOVERY_FSTAB_SUFFIX3)
# TARGET_RECOVERY_FSTAB := $(RECOVERYCOMM)/recovery$(RECOVERY_FSTAB_SUFFIX).fstab
# $(warning RECOVERY_FSTAB=$(TARGET_RECOVERY_FSTAB))
# SPRD: add nvmerge config
TARGET_RECOVERY_NVMERGE_CONFIG := $(PLATCOMM)/nvmerge.cfg
#SPRD:modem update config
MODEM_UPDATE_CONFIG := true
MODEM_UPDATE_CONFIG_FILE := $(PLATCOMM)/modem.cfg

# default value is 512M, using resize to adapter real size
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912

BOARD_RESERVED_SPACE_ON := true

#SPRD:SUPPORT_64BIT_MEDIA
TARGET_SUPPORT_64BIT_MEDIA := true

#SPRD：AVIExtractorEx
USE_AVIExtractorEx :=true

#SPRD：WAVExtractorEx
USE_WAVExtractorEx :=true

#SPRD: Use High Quality Dyn SRC
USE_HIGH_QUALITY_DYN_SRC :=true

#SPRD：SUPPORT IMAADPCM
SUPPORT_IMAADPCM :=true

#SPRD：SUPPORT FLVExtractor
SUPPORT_FLVExtractor :=true
#SPRD:SUPPORT PSXSTRExtractor
SUPPORT_PSXSTRExtractor :=true

#SPRD: support wcnd eng mode
USE_SPRD_ENG :=true

CP_LOG_DIR_IN_AP := ylog

# WiFi
SPRD_CP_LOG_WCN := MARLIN2

#BBAT GPIO ADDRESS
SHARKLE_BBAT_GPIO := true

#BBAT 32bit or 64bit
SHARKLE_BBAT_BIT64 := true

#sharkle support 1080i
CONFIG_1080I_THUMBNAIL := true
# GPU
override TARGET_GPU_PLATFORM := midgard
override MALI_PLATFORM_NAME := sharkle
GPU_GRALLOC_INCLUDES := $(TOP)/vendor/sprd/external/drivers/gpu/$(TARGET_GPU_PLATFORM)/include
$(warning MALI_PLATFORM_NAME:$(MALI_PLATFORM_NAME))

ifeq ($(strip $(TARGET_GPU_PLATFORM)),midgard)
#    DEVICE_USE_OFFILNE_COMPILER_SHADER := true
endif

SUPPORT_RGB_ENC := true

#SUPPORT LOWPOWER WITH LCD 30 FPS
POWER_HINT_VIDEO_LOWPOWER_DISPLAY :=true

#SPRD: streaming extention, AOSP should be false.
USE_SPRD_STREAMING_EX := true

TARGET_PROVIDES_B2G_INIT_RC := true
GET_FRAMEBUFFER_FORMAT_FROM_HWC := true

#for sp9820 camera, bypass binning, hist and hist2 to economize memory
TARGET_BOARD_ECONOMIZE_MEMORY := true
