#
# SPDX-FileCopyrightText: The Paranoid Android Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from vili device
$(call inherit-product, device/xiaomi/vili/device.mk)

# Inherit from AOSPA common product configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1080

# Device identifier
PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := vili
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2107113SG
PRODUCT_NAME := aospa_vili

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildFingerprint=Xiaomi/vili_global/vili:14/UKQ1.231207.002/V816.0.22.0.UKDMIXM:user/release-keys \
    DeviceProduct=vili \
    SystemName=vili_global

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
