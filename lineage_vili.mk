#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from vili device
$(call inherit-product, device/xiaomi/vili/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Axion Flags
AXION_CAMERA_REAR_INFO := 108,8,5
AXION_CAMERA_FRONT_INFO := 16
AXION_MAINTAINER := kxshik
AXION_PROCESSOR := Snapdragon©_888
TARGET_INCLUDES_LOS_PREBUILTS := false
WITH_GMS := true
TARGET_DISABLE_EPPE := true
TARGET_NEEDS_VULKAN_MEDIA_FIX := true
TARGET_SUPPORTED_REFRESH_RATES := 60,120
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_ENABLE_BLUR := true
TARGET_SUPPORTS_QUICK_TAP := true

# Device identifier
PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := vili
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2107113SG
PRODUCT_NAME := lineage_vili

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="vili_global-user 14 UKQ1.231207.002 V816.0.22.0.UKDMIXM release-keys" \
    BuildFingerprint=Xiaomi/vili_global/vili:14/UKQ1.231207.002/V816.0.22.0.UKDMIXM:user/release-keys \
    DeviceProduct=vili \
    SystemName=vili_global

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
