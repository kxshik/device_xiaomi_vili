#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8350-common
$(call inherit-product, device/xiaomi/sm8350-common/common.mk)

# Axion kernel manager
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ax_kernel_manager.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/ax_kernel_manager.xml

# Fingerprint
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.fx.tunnel@1.0.vendor

# MIUI Camera
$(call inherit-product-if-exists, vendor/xiaomi/camera/miuicamera.mk)
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

# Overlays
PRODUCT_PACKAGES += \
    ApertureOverlayVili

PRODUCT_PACKAGES += \
    FrameworkOverlayVili \
    SettingsOverlayVili \
    SettingsProviderOverlayVili \
    SystemUIOverlayVili \
    WifiOverlayVili \
    NfcOverlayVili

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rro_overlays/config-odm.xml:$(TARGET_COPY_OUT_ODM)/overlay/config/config.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=6000 \
    ro.surface_flinger.set_touch_timer_ms=6000 \
    ro.surface_flinger.set_display_power_timer_ms=1000

# Vibrator
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.xiaomi)
$(call soong_config_set_bool,qti_vibrator,use_effect_stream,true)

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/vili/vili-vendor.mk)
