#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from vili device
$(call inherit-product, device/xiaomi/vili/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := vili
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2107113SG
PRODUCT_NAME := lineage_vili

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="vili-user 14 UKQ1.231207.002 V816.0.10.0.UKDMIXM release-keys" \
    BuildFingerprint=Xiaomi/vili/vili:14/UKQ1.231207.002/V816.0.10.0.UKDMIXM:user/release-keys

# Define rear camera specs
AXION_CAMERA_REAR_INFO := 108,8,5

# Define front camera specs
AXION_CAMERA_FRONT_INFO := 16

# Maintainer name
AXION_MAINTAINER := swiitchOFF

# Processor name
AXION_PROCESSOR := Qualcomm_Snapdragon_888_5G

# Blur
TARGET_ENABLE_BLUR := true

# Gapps
WITH_GMS := true
WITH_GMS_VARIANT := pico
